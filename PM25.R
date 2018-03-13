# Wroclaw station codes ########################################################
#
## old:
# DsWrocWisA    Wrocław - Wiśniowa
# DsWrocBartA   Wrocław - Bartnicza
# DsWrocGrobla  Wrocław - Na Grobli
# DsWrocOrzech  Wrocław - Orzechowa
# DsWrocKorzA   Wrocław - Korzeniowskiego
#
#
## new:
# DsWrocAlWisn  Wrocław - Wiśniowa
# DsWrocBartni  Wrocław - Bartnicza
# DsWrocNaGrob  Wrocław - Na Grobli
# DsWrocOrzech  Wrocław - Orzechowa
# DsWrocWybCon  Wrocław - Korzeniowskiego



# Download and extract data from GIOŚ
# http://powietrze.gios.gov.pl/pjp/archives

# unzip
#bla bla bla

LoadPollutionData <- function(PollutionType = "PM10"){

  # Load packages
  library(curl)
  library(ggplot2)
  library(xlsx)
  library(XLConnect)
  library(mice)
  library(VIM)
  library(reshape2)

  pt <- paste("_", PollutionType, "_24g.xlsx", sep = "")

  # load files into data frames and data frames into a list
  n <- c(2000:2015)
  pollution <- list()

  for (i in n) {
    f <- paste('data/', i, '/', i, pt, sep = '', collapse = NULL)
    x <- readWorksheetFromFile(f, sheet = 1, header = T, startCol = 1)
    name <- (paste('pollution_', i, sep = ''))
    pollution[[name]] <-  x
  }

  # extract columns for Wroc and store in a new list
  Wroc_temp <- list()
  l <- c(1:length(pollution))
  for (i in l) {
    colIndex <- grep("Wroc", colnames(pollution[[i]]))
    name <- names(pollution[i])
    colIndex <- append(colIndex, 1, 0)
    Wroc_temp[[name]] <- pollution[[i]][colIndex]
  }

  # remove top two rows with attribute names
  # head(PM10[[1]], 10)
  l <- c(1:length(pollution))
  for (i in l) {
    Wroc_temp[[i]] <- Wroc_temp[[i]][c(-1:-2), ]
  }

  # convert first column to date and change header ####
  # PollWroc == Pollution in Wroclaw
  PollWroc <- Wroc_temp
  l <- c(1:length(Wroc_temp))
  for (i in l) {
    PollWroc[[i]][, 1] <- as.Date(Wroc_temp[[i]][, 1])
    colnames(PollWroc[[i]])[1] <- "DataObserwacji"
  }
  remove(Wroc_temp)

  # convert measures from char to numeric and calculate mean for whole city ####
  # convert
  l <- c(1:length(PollWroc))
  for (i in l) {
    nc <- c(2:ncol(PollWroc[[i]]))
    for (j in nc) {
      PollWroc[[i]][, j] <- as.numeric(PollWroc[[i]][, j])
    }
  }

  # do the means
  l <- c(1:length(PollWroc))
  for (i in l) {
    nc <- c(2:ncol(PollWroc[[i]]))
    if (length(nc) > 1) {
      PollWroc[[i]]$Srednia <- apply(PollWroc[[i]][, nc], 1, mean, na.rm = T)
    } else {
      PollWroc[[i]]$Srednia <- PollWroc[[i]][, 2]
    }
  }

  # bind the means from all data frames
  l <- c(1:length(PollWroc))
  PollWrocFinal <- data.frame(matrix(ncol = 2, nrow = 0))
  colnames(PollWrocFinal) <- c("DataObserwacji", "Srednia")

  for (i in l) {
    nc <- ncol(PollWroc[[i]])
    PollWrocFinal <- rbind(PollWrocFinal, PollWroc[[i]][, c(1,nc)])
  }

  PollWrocFinal[is.nan(PollWrocFinal$Srednia), 2] <- NA

  return(PollWrocFinal)
}

t <- LoadPollutionData()

# plots ########################################################################
plot(t$DataObserwacji, t$Srednia,
     type = "l",
     col = "black",
     lwd = 0.5)
abline(h = mean(t$Srednia, na.rm = T))
ma <- filter(t$Srednia, filter = rep(1/20, 20))
lines(t$DataObserwacji, ma, lwd = 2, col = 'red')




# handling missing data ########################################################
# https://www.r-bloggers.com/imputing-missing-data-with-r-mice-package/
# https://www.analyticsvidhya.com/blog/2016/03/tutorial-powerful-packages-imputing-missing-values/

missing <- md.pattern(t)
mice_plot <- aggr(t)

t.v1 <- data.frame(c(1:nrow(t)), t$Srednia)

t.v2 <- mice(t.v1,
                      m = 5,
                      maxit = 50,
                      method = 'pmm',
                      seed = 500)

t.v3 <- data.frame(t$DataObserwacji, complete(t.v2)[,2])
names(t.v3) <- c("DataObserwacji", "Srednia")


# time series plot##############################################################
plot(t.v3$DataObserwacji, t.v3$Srednia,
     type = "l",
     col = "black",
     lwd = 0.5)
#abline(h = mean(PM10WrocFinal.v3$Srednia, na.rm = T)
abline(lm(t.v3$Srednia ~ t.v3$DataObserwacji))
ma <- filter(t.v3$Srednia, filter = rep(1/30, 30))
lines(t.v3$DataObserwacji, ma, lwd = 3, col = 'red')

qplot(t.v3$DataObserwacji, ma, geom = "line")

ggplot(t.v3, aes(x = DataObserwacji)) +
  geom_line(aes(y = Srednia), colour = "grey") +
  geom_line(aes(y = ma), colour = "red")


# prepare for aggregations #####################################################
# http://www.cookbook-r.com/Manipulating_data/Changing_the_order_of_levels_of_a_factor/

PM10WrocFinal.v3$Miesiace <- factor(months(PM10WrocFinal.v3$DataObserwacji, FALSE),
                                    levels = month.name)

PM10WrocFinal.v3$Dni <- factor(weekdays(PM10WrocFinal.v3$DataObserwacji, FALSE),
                               levels = weekdays(Sys.Date() + 1:7, FALSE))

PM10WrocFinal.v3$Rok <- as.factor(year(PM10WrocFinal.v3$DataObserwacji))


# aggregate by month ###########################################################

MeanMonth <- aggregate(x = PM10WrocFinal.v3$Srednia,
                by = list(Dzien = substr(PM10WrocFinal.v3$DataObserwacji, 9, 10),
                          Miesiac = PM10WrocFinal.v3$Miesiace), mean)
MeanMonth$FakeDate <- as.Date(paste(MeanMonth$Dzien, MeanMonth$Miesiac), "%d %B")

#faking time series for 2017, however there is no 29th Feb in 2017,
#so we need to remove it:
MeanMonth <- MeanMonth[!is.na(MeanMonth$FakeDate),]

plot(MeanMonth$FakeDate, MeanMonth$x,
     type = "l",
     col = "black",
     lwd = 1,
     main = "PM10 we Wro",
     xlab = "Miesiąc",
     ylab = "PM10",
     bty = "n"
     )
ma <- filter(MeanMonth$x, filter = rep(1/10, 10))
lines(MeanMonth$FakeDate, ma, lwd = 3, col = 'red')
grid()

# aggregate by day of a week ###################################################
MeanDay <- aggregate(x = PM10WrocFinal.v3$Srednia,
                       by = list(Dzien = PM10WrocFinal.v3$Dni), mean)



# aggregate by time for winter months ##########################################
