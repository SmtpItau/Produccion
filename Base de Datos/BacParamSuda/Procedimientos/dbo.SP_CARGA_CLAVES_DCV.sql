USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_CLAVES_DCV]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGA_CLAVES_DCV]
   (   @Tag       CHAR(1)
   ,   @Numoper   NUMERIC(9)   = 0
   ,   @Numdocu   NUMERIC(9)   = 0
   ,   @Correla   NUMERIC(9)   = 0
   ,   @Clave     VARCHAR(20)  = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iFound   INTEGER

   IF @Tag = 'V'
   BEGIN
      SELECT   @iFound = -1
      SELECT   @iFound = 0
      FROM     bactradersuda..MDMO with (nolock)
      WHERE    monumoper = @Numoper
      AND      motipoper IN('RC','RCA')
   
      IF @iFound = -1
      BEGIN
         SELECT -1 , 'W - No es posible asignar claves a la operación.'
      END ELSE
      BEGIN
         SELECT 0 , ''
      END
   END

   IF @Tag = 'C'
   BEGIN
      SELECT   monumoper    as Operacion
      ,        monumdocu    as Documento  
      ,        mocorrela    as Correlativo
      ,        moinstser    as Serie
      ,        monominal    as Nominal
      ,        modcv        as Custodia 
      ,        moclave_dcv  as Clave
      FROM     bactradersuda..MDMO with (nolock)
      WHERE    monumoper = @Numoper
      AND      motipoper IN('RC','RCA')
      ORDER BY monumdocu , mocorrela
   END

   IF @Tag = 'A'
   BEGIN
      UPDATE   bactradersuda..MDMO
      SET      modcv       = 'D'
      ,        moclave_dcv = @Clave
      WHERE    monumoper   = @Numoper
      AND      monumdocu   = @Numdocu
      AND      mocorrela   = @Correla
      AND      motipoper IN('RC','RCA')
   END

END
GO
