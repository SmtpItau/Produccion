USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONPRIORIDADMONEDAS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONPRIORIDADMONEDAS]
   
AS
BEGIN

   SET NOCOUNT ON 

		Select MnCodMon
		         , mnnemo
		         , mnglosa
		         , MnPrioridad =  isnull( (select MnPRioridad 
		                                   from BacParamSuda..MonedaPrioridad Pri
		                                   where Pri.MnCodMon = Mda.MnCodMon)
		                                   , case when Mda.MnCodMon = 999 then 0 
		                                          when Mda.MnCodMon = 998 then 1
		                                          when Mda.MnCodMon = 13  then 2
		                                          else 3 end )
		
		Into #MonedaPrioridad
		from BacParamSuda..Moneda Mda
		Where mnmx = 'C'
		Union
		Select MnCodMon 
		         , mnnemo 
		         , mnglosa 
		         , MnPrioridad = isnull( (select MnPrioridad 
		                                  from BacParamSuda..MonedaPrioridad Pri
		                                  where Pri.MnCodMon = Mda.MnCodMon)
		                                  , case when Mda.MnCodMon = 999 then 0 
		                                         when Mda.MnCodMon = 998 then 1
		                                         when Mda.MnCodMon = 13  then 2
		                                         else 3 end )
		from BacParamSuda..Moneda Mda
		where MnCodMon in ( 999, 998 )
		
		SELECT * FROM #MonedaPrioridad ORDER BY MnPrioridad
	
END
GO
