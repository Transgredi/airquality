SELECT `Kod stacji`, Station_Code, Pollution_Level FROM 
	(SELECT `Kod stacji`, 'DsWrocWie' as Station_Code, DsWrocWie as Pollution_Level from 2000_pm10_24g 
      UNION ALL 
      SELECT `Kod stacji`, 'KpCiechoTezniowa' as Station_Code, KpCiechoTezniowa as Pollution_Level from 2000_pm10_24g 
      UNION ALL 
      SELECT `Kod stacji`, 'LdLodzWSSEMWodna40' as Station_Code, LdLodzWSSEMWodna40 as Pollution_Level from 2000_pm10_24g 
      UNION ALL 
      SELECT `Kod stacji`, 'MpKrakowWIOSAKra6117' as Station_Code, MpKrakowWIOSAKra6117 as Pollution_Level from 2000_pm10_24g 
      UNION ALL 
      SELECT `Kod stacji`, 'MpKrakowWIOSPrad6115' as Station_Code, MpKrakowWIOSPrad6115 as Pollution_Level from 2000_pm10_24g 
      UNION ALL 
      SELECT `Kod stacji`, 'MzWarszKrucza' as Station_Code, MzWarszKrucza as Pollution_Level from 2000_pm10_24g 
      UNION ALL 
      SELECT `Kod stacji`, 'PkPrzemWIOSDolin' as Station_Code, PkPrzemWIOSDolin as Pollution_Level from 2000_pm10_24g) x;
      
      
      SELECT `Kod stacji`, Station_Code, Pollution_Level FROM (SELECT `Kod stacji`, 'DsWrocWie' as Station_Code, DsWrocWie as Pollution_Level FROM 2000_pm10_24g
      UNION ALL SELECT `Kod stacji`, 'KpCiechoTezniowa' as Station_Code, KpCiechoTezniowa as Pollution_Level FROM 2000_pm10_24g
      UNION ALL SELECT `Kod stacji`, 'LdLodzWSSEMWodna40' as Station_Code, LdLodzWSSEMWodna40 as Pollution_Level FROM 2000_pm10_24g
      UNION ALL SELECT `Kod stacji`, 'MpKrakowWIOSAKra6117' as Station_Code, MpKrakowWIOSAKra6117 as Pollution_Level FROM 2000_pm10_24g
      UNION ALL SELECT `Kod stacji`, 'MpKrakowWIOSPrad6115' as Station_Code, MpKrakowWIOSPrad6115 as Pollution_Level FROM 2000_pm10_24g
      UNION ALL SELECT `Kod stacji`, 'MzWarszKrucza' as Station_Code, MzWarszKrucza as Pollution_Level FROM 2000_pm10_24g
      UNION ALL SELECT `Kod stacji`, 'PkPrzemWIOSDolin' as Station_Code, PkPrzemWIOSDolin as Pollution_Level FROM 2000_pm10_24g
      ) x;
