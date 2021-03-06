USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTIPOINSTRUMENTO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTIPOINSTRUMENTO]	(	@Proc   DATETIME
						,	@CodIns NUMERIC
						)
AS
BEGIN
SET NOCOUNT ON

select Instrumento = cpcodigo 
     , Nemo = case when cpcodigo = 20 then 'LH' else cpinstser end
     , PlazoRemanente = datediff( dd, @Proc, cpfecven )
     , PlazoDesde = datediff( dd, @Proc, cpfecven ) - 1 
     , PlazoHasta = datediff( dd, @Proc, cpfecven ) + 1 
     , PlazoRemanenteAnnos = datediff( dd, @Proc, cpfecven )/360.0 
     , FechaVcto = cpfecven
INTO #Temporal
from BacTraderSuda..mdCp where CpNominal <> 0  and CpCodigo = @CodIns -- select * from mdCp
Union
select Instrumento = vicodigo 
     , Nemo = case when   vicodigo = 20 then 'LH' else viinstser end
     , PlazoRemanente = datediff( dd, @Proc, Vifecven )
     , PlazoDesde = datediff( dd, @Proc, Vifecven ) - 1
     , PlazoHasta = datediff( dd, @Proc, Vifecven ) + 1 
     , PlazoRemanenteAnnos = datediff( dd, @Proc, Vifecven )/360.0 
     , FechaVcto = Vifecven
 from BacTraderSuda..mdvi where viNominal <> 0  and viCodigo = @CodIns  -- select * from mdvi
Union
select Instrumento = cicodigo 
     , Nemo = case when cicodigo = 20 then 'LH' else ciinstser end
     , PlazoRemanente = datediff( dd, @Proc, cifecven )
     , PlazoDesde = datediff( dd, @Proc, Cifecven ) - 1 
     , PlazoHasta = datediff( dd, @Proc, Cifecven ) + 1 
     , PlazoRemanenteAnnos = datediff( dd, @Proc, Cifecven )/360.0 
     , FechaVcto = Cifecven
from BacTraderSuda..mdCi where CiNominal <> 0  and CiCodigo = @CodIns  -- select * from mdCp

order by FechaVcto, Nemo

delete #Temporal where Nemo in ( select trserie from BacParamSuda..TASA_REFERENCIA_SOMA )

select * from #Temporal


END
SET NOCOUNT OFF
GO
