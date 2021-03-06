USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SEG_FAMILIA_FM_SIN_METOD]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_SEG_FAMILIA_FM_SIN_METOD]
 (   @cod_segmento   CHAR(6)
 )
AS 
BEGIN

        SET NOCOUNT ON
        SELECT Id = RTRIM( CONVERT( VARCHAR( 14) , ClRut_Padre ) ) + RTRIM( CONVERT( VARCHAR(5), ClCodigo_Padre ) )
             , ClRut    = ClRut_Padre
             , ClCodigo = ClCodigo_Padre
             , Afecta_Lineas_Hijo 
        INTO #Familia
        FROM BacLineas..CLIENTE_RELACIONADO  --  select * from BacLineas..CLIENTE_RELACIONADO 
            , Cliente         
        WHERE ClRut_padre = Clrut and ClCodigo_Padre = ClCodigo -- Pensamos que @rut es padre
        UNION
        -- Carga en tabla #FAMILIA el rut del hijo si @rut es hijo
        SELECT Id = RTRIM( CONVERT( VARCHAR( 14) , ClRut_Padre ) ) + RTRIM( CONVERT( VARCHAR(5), ClCodigo_Padre ) )
             , ClRut    = ClRut_Padre
             , ClCodigo = ClCodigo_Padre
             , Afecta_Lineas_Hijo
        FROM BacLineas..CLIENTE_RELACIONADO 
           , Cliente
        WHERE ClRut_Hijo = Clrut and ClCodigo_Hijo = ClCodigo   -- pensamos que @rut es hijo
        -- Se gregan en #Familia todos los hijos del padre
        INSERT INTO #Familia
        SELECT Id = RTRIM( CONVERT( VARCHAR( 14) , ClRut_Hijo ) ) + RTRIM( CONVERT( VARCHAR(5), ClCodigo_Hijo ) )
             , ClRut    = ClRut_Hijo
             , ClCodigo = ClCodigo_Hijo
             , Afecta_Lineas_Hijo = Hijo.Afecta_Lineas_Hijo
          FROM BacLineas..CLIENTE_RELACIONADO Hijo
               , #FAMILIA Padre WHERE Padre.ClRut = Hijo.ClRut_Padre and Padre.ClCodigo = Hijo.ClCodigo_Padre

       IF EXISTS ( SELECT  1  
       FROM  #Familia a
           , Cliente  b
       WHERE a.ClRut    = b.ClRut
           AND   a.Afecta_Lineas_Hijo = 1
           AND   b.seg_comercial =@cod_segmento
           AND   b.ClRecMtdCod = 0) 
           

               SELECT 1
       ELSE
               SELECT 0

END

GO
