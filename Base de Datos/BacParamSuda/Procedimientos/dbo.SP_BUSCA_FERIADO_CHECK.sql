USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_FERIADO_CHECK]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_FERIADO_CHECK](  @Fecha		DATETIME	 OUTPUT
										   , @CHECK_USA		NUMERIC(1,0) OUTPUT
										   , @CHECK_ING		NUMERIC(1,0) OUTPUT
										   , @CHECK_SCL		NUMERIC(1,0) OUTPUT
										   , @Codigo		VARCHAR(100)
										   , @profundidad	INT = 0 )

AS
BEGIN
	   set nocount on
       declare @fechaAux datetime
	   declare @CadenaPaises varchar(40)
	   
	   set @CadenaPaises = ''
	   select @fechaAux = dbo.fx_regla_feriados_internacionales(@fecha, ';6;') 
	   Set    @CHECK_SCL = case when @Fecha <> @FechaAux then 1 else 0 end
	   set    @CadenaPaises =  @CadenaPaises + case when @fecha <> @fechaAux then ';6' else '' end
	  	 
       select @fechaAux = dbo.fx_regla_feriados_internacionales(@fecha, ';225;') 
	   Set    @CHECK_USA = case when @Fecha <> @FechaAux then 1 else 0 end
	   set    @CadenaPaises =  @CadenaPaises + case when @fecha <> @fechaAux then ';225' else '' end

	   select @fechaAux = dbo.fx_regla_feriados_internacionales(@fecha, ';510;') 
	   Set    @CHECK_ING = case when @Fecha <> @FechaAux then 1 else 0 end
	   set    @CadenaPaises =  @CadenaPaises + case when @fecha <> @fechaAux then ';510' else '' end

	   set    @CadenaPaises = @CadenaPaises + ';'

	   -- set   @fecha = dbo.fx_regla_feriados_internacionales(@fecha, @CadenaPaises )
	   -- No modificará la fecha, solo debe indicar en qué pais 
	   -- debe ser feriado.

	   SELECT @Fecha,
	          @CHECK_USA,
	          @CHECK_ING,
	          @CHECK_SCL

    set nocount off
	 
END

	/* Pruebas internas version anterior
	2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250101',0,0,0,';6;225;510;',0 --02 Enero 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250120',0,0,0,';6;225;510;',0 --20 ENERO 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250217',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250418',0,0,0,';6;225;510;',0 --22 Abril 2025--
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250419',0,0,0,';6;225;510;',0 --22 Abril 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250501',0,0,0,';6;225;510;',0 --02 Mayo 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250505',0,0,0,';6;225;510;',0 --06 Mayo 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250521',0,0,0,';6;225;510;',0 --22 Mayo 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250526',0,0,0,';6;225;510;',0 --27 Mayo 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250629',0,0,0,';6;225;510;',0 --30 Junio 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250704',0,0,0,';6;225;510;',0 --07 Julio 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250716',0,0,0,';6;225;510;',0 --17 Julio 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250815',0,0,0,';6;225;510;',0 --18 Agosto 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250825',0,0,0,';6;225;510;',0 --26 Agosto 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250901',0,0,0,';6;225;510;',0 --02 Sep 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250918',0,0,0,';6;225;510;',0 --22 Sep 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20250919',0,0,0,';6;225;510;',0 --22 Sep 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20251012',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20251013',0,0,0,';6;225;510;',0 --14 Oct 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20251031',0,0,0,';6;225;510;',0 --03 Nov 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20251101',0,0,0,';6;225;510;',0 --03 Nov 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20251111',0,0,0,';6;225;510;',0 --12 Mov 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20251127',0,0,0,';6;225;510;',0 --28 Nov 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20251208',0,0,0,';6;225;510;',0 --09 Dic 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20251225',0,0,0,';6;225;510;',0 --29 Dic 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20251226',0,0,0,';6;225;510;',0 --29 Dic 2025
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20251231',0,0,0,';6;225;510;',0
	
	
	2021
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210101',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210118',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210215',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210402',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210403',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210405',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210501',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210503',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210521',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210531',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210628',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210704',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210705',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210716',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210815',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210830',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210906',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210918',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210919',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20211011',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20211031',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20211101',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20211111',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20211125',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20211208',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20211225',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20211226',0,0,0,';6;225;510;',0 
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20211231',0,0,0,';6;225;510;',0	
	
	
	
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20160325',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20160328',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20160628',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20161226',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20161227',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20181112',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20230101',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20230102',0,0,0,';6;225;510;',0
	EXEC dbo.SP_BUSCA_FERIADO_CHECK '20210705',0,0,0,';6;225;510;',0
 	
*/
GO
