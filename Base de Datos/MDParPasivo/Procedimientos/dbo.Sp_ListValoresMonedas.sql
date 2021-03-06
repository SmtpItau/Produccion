USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ListValoresMonedas]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_ListValoresMonedas]
   (   @xfecha   CHAR(10)   
   ,   @moneda   NUMERIC(9) 
   ,   @Usuario  VARCHAR(15) )
AS
BEGIN

SET NOCOUNT ON
SET DATEFORMAT dmy

      DECLARE  @acfecproc      CHAR(10)
      ,        @acfecprox      CHAR(10)
      ,        @uf_hoy         NUMERIC(21,4)
      ,        @uf_man         NUMERIC(21,4)
      ,        @ivp_hoy        NUMERIC(21,4)
      ,        @ivp_man        NUMERIC(21,4)
      ,        @do_hoy         NUMERIC(21,4)
      ,        @do_man         NUMERIC(21,4)
      ,        @da_hoy         NUMERIC(21,4)
      ,        @da_man         NUMERIC(21,4)
      ,        @acnomprop      CHAR(40)
      ,        @rut_empresa    CHAR(12)
      ,        @hora           CHAR(8)
      ,        @xfecha_busqueda DATETIME 
      ,        @fec            CHAR(10)
      ,        @contador       INT

    --  SELECT   @xfecha          = CONVERT(DATETIME,@xfecha,112)
      SELECT   @xfecha_busqueda = (SELECT Fecha_Proceso FROM DATOS_GENERALES)
	
      EXECUTE  Sp_Base_Del_Informe     
               @acfecproc      OUTPUT
      ,        @acfecprox      OUTPUT
      ,        @uf_hoy         OUTPUT
      ,        @uf_man         OUTPUT
      ,        @ivp_hoy        OUTPUT
      ,        @ivp_man        OUTPUT
      ,        @do_hoy         OUTPUT
      ,        @do_man         OUTPUT
      ,        @da_hoy         OUTPUT
      ,        @da_man         OUTPUT
      ,        @acnomprop      OUTPUT
      ,        @rut_empresa    OUTPUT
      ,        @hora           OUTPUT
      ,        @xfecha_busqueda 

      SELECT  'Uf_hoy' = @uf_hoy
      ,       'Uf_Cie' = @uf_man
      ,       'Ivp_ho' = @ivp_hoy
      ,       'Do_Hoy' = @do_hoy
      ,       'Do_Cie' = @do_man
      ,       'Fe_Pro' = CONVERT(CHAR(10),@xfecha_busqueda,103)
      ,       'Fe_Emi' = CONVERT(CHAR(10),GETDATE(),103)
      ,       'Ho_Emi' = CONVERT(CHAR(10),GETDATE(),108)
      ,       'Titulo' = 'INFORME DE VALORES DE MONEDA ' + LTRIM(RTRIM((SELECT mnglosa FROM MONEDA WHERE mncodmon = @moneda AND ESTADO<>'A' )))  + ' AÑO ' + CONVERT(CHAR(4),DATEPART(YEAR,@xfecha))
      ,       'Usuari' = @Usuario + ' /BAC-PARAMETROS'
      INTO    #BASE_INFORME





      CREATE TABLE  #VALOR_MONEDA
        (   Dia          NUMERIC(2)    DEFAULT (0) 
        ,   Enero        NUMERIC(19,4) DEFAULT (0)
        ,   Febrero      NUMERIC(19,4) DEFAULT (0)
        ,   Marzo        NUMERIC(19,4) DEFAULT (0)
        ,   Abril        NUMERIC(19,4) DEFAULT (0)
        ,   Mayo         NUMERIC(19,4) DEFAULT (0)
        ,   Junio        NUMERIC(19,4) DEFAULT (0)
        ,   Julio        NUMERIC(19,4) DEFAULT (0)
        ,   Agosto       NUMERIC(19,4) DEFAULT (0)
        ,   Septiembre   NUMERIC(19,4) DEFAULT (0)
        ,   Octubre      NUMERIC(19,4) DEFAULT (0)
        ,   Noviembre    NUMERIC(19,4) DEFAULT (0)
        ,   Diciembre    NUMERIC(19,4) DEFAULT (0)
        )
      

      SELECT   @Contador = 1

      WHILE @Contador <= 31 
      BEGIN

         INSERT INTO  #VALOR_MONEDA
            ( Dia )
         VALUES
            ( @contador )

         SELECT @contador = @contador +1

      END
	
      UPDATE #VALOR_MONEDA SET Enero = ISNULL(vmvalor,0)
      FROM   VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 1
      AND    YEAR(vmfecha) = @xfecha
      AND    vmcodigo      = @moneda 

      UPDATE #VALOR_MONEDA SET Febrero = ISNULL(vmvalor,0)
      FROM   VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 2
      AND    YEAR(vmfecha) =@xfecha
      AND    vmcodigo      = @moneda 

      UPDATE #VALOR_MONEDA SET Marzo = ISNULL(vmvalor,0)
      FROM   VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 3
      AND    YEAR(vmfecha) = @xfecha
      AND    vmcodigo      = @moneda 

      UPDATE #VALOR_MONEDA SET Abril = ISNULL(vmvalor,0)
      FROM  VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 4
      AND    YEAR(vmfecha) = @xfecha
      AND    vmcodigo      = @moneda 

      UPDATE #VALOR_MONEDA SET Mayo = ISNULL(vmvalor,0)
      FROM   VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 5
      AND    YEAR(vmfecha) =@xfecha
      AND    vmcodigo      = @moneda 

      UPDATE #VALOR_MONEDA SET Junio = ISNULL(vmvalor,0)
      FROM   VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 6
      AND    YEAR(vmfecha) = @xfecha
      AND    vmcodigo      = @moneda 

      UPDATE #VALOR_MONEDA SET Julio = ISNULL(vmvalor,0)
      FROM   VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 7
      AND    YEAR(vmfecha) = @xfecha
      AND    vmcodigo      = @moneda 

      UPDATE #VALOR_MONEDA SET Agosto = ISNULL(vmvalor,0)
      FROM   VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 8
      AND    YEAR(vmfecha) = @xfecha
      AND    vmcodigo      = @moneda 

      UPDATE #VALOR_MONEDA SET Septiembre = ISNULL(vmvalor,0)
      FROM   VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 9
      AND    YEAR(vmfecha) = @xfecha
      AND    vmcodigo      = @moneda 

      UPDATE #VALOR_MONEDA SET Octubre = ISNULL(vmvalor,0)
      FROM   VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 10
      AND    YEAR(vmfecha) = @xfecha
      AND    vmcodigo      = @moneda 

      UPDATE #VALOR_MONEDA SET Noviembre = ISNULL(vmvalor,0)
      FROM   VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 11
      AND    YEAR(vmfecha) =@xfecha
      AND    vmcodigo      = @moneda 

      UPDATE #VALOR_MONEDA SET Diciembre = ISNULL(vmvalor,0) 
      FROM   VALOR_MONEDA
      WHERE  DAY(vmfecha)  = Dia
      AND    MONTH(vmfecha)= 12
      AND    YEAR(vmfecha) =@xfecha
      AND    vmcodigo      = @moneda 

      SELECT * FROM #VALOR_MONEDA , #BASE_INFORME

SET NOCOUNT OFF

END




GO
