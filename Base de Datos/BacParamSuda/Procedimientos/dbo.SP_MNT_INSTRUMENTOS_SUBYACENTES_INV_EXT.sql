USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_INSTRUMENTOS_SUBYACENTES_INV_EXT]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_INSTRUMENTOS_SUBYACENTES_INV_EXT]
   (   @cEvento       CHAR(3)
   ,   @iCod_Familia  NUMERIC(5)   = 0
   ,   @cCod_Nemo     CHAR(20)     = ''
   ,   @dFecha_Vcto   DATETIME     = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @cEvento = 'CON'
   BEGIN
      SELECT i.Cod_Familia , i.Cod_Nemo , i.Fecha_Vcto , s.nom_nemo
      FROM   BacFwdSuda..INSTRUMENTOS_SUBYACENTES_INV_EXT i
             LEFT JOIN BacBonosExtSuda..TEXT_SER s ON i.Cod_Familia = s.Cod_Familia AND i.Cod_Nemo = s.Cod_Nemo
      WHERE (i.Cod_Nemo    = @cCod_Nemo or @cCod_Nemo = '')
      ORDER BY i.Cod_Nemo
   END

   IF @cEvento = 'HLP'
   BEGIN
      SELECT DISTINCT Cod_familia , cod_nemo , CONVERT(CHAR(10),fecha_vcto ,103)
      FROM   BacBonosExtSuda..TEXT_SER 
      WHERE  cod_nemo NOT IN(SELECT Cod_Nemo FROM BacFwdSuda..INSTRUMENTOS_SUBYACENTES_INV_EXT)
      ORDER BY cod_nemo 
   END   

   IF @cEvento = 'GRB'
   BEGIN
      INSERT INTO BacFwdSuda..INSTRUMENTOS_SUBYACENTES_INV_EXT
      SELECT @iCod_Familia
      ,      @cCod_Nemo
      ,      @dFecha_Vcto
   END   
   
   IF @cEvento = 'DEL'
   BEGIN
      DELETE BacFwdSuda..INSTRUMENTOS_SUBYACENTES_INV_EXT
      WHERE  Cod_Familia = @iCod_Familia AND Cod_Nemo = @cCod_Nemo
   END

   IF @cEvento = 'VAL'
   BEGIN
      IF NOT EXISTS( SELECT 1 FROM BacBonosExtSuda..TEXT_SER WHERE cod_nemo = @cCod_Nemo )
      BEGIN
         SELECT -1 , 'Serie no se ha creado en Mantenedor de Instrumentos'
         RETURN
      END
      IF EXISTS(SELECT 1 FROM BacFwdSuda..INSTRUMENTOS_SUBYACENTES_INV_EXT WHERE cod_nemo = @cCod_Nemo)
      BEGIN
         SELECT -1 ,'Instrumento ya se encuentra asignado.'
         RETURN
      END
      SELECT 0 , Cod_familia , cod_nemo , nom_nemo  , fecha_vcto FROM BacBonosExtSuda..TEXT_SER
      WHERE cod_nemo = @cCod_Nemo
   END

END

GO
