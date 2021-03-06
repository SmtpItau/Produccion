USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLAZO_INICIO_LIMITE]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PLAZO_INICIO_LIMITE]
                                       ( @Tipo_Limite  CHAR(10)    ,
                                         @Plazo        NUMERIC(6)  ,
                                         @Rut          NUMERIC(10) ,
                                         @Codigo       NUMERIC(1)  ,
                                         @Instrumento  CHAR(3)     ,
                                         @Plazo_Limite NUMERIC(6)  OUTPUT )
AS
BEGIN
SET NOCOUNT ON
DECLARE @Regs        INTEGER   ,
        @Cont        INTEGER   ,
        @Plazo_Ini   NUMERIC(6),
        @Plazo_Ini2  NUMERIC(6),
        @Plazo_Fin   NUMERIC(6),
        @Plazo_Fin2  NUMERIC(6)
SELECT @Plazo_Limite = 1
IF @Tipo_Limite = 'EMISOR'
BEGIN
   SELECT @Regs = COUNT(*) 
     FROM MD_EMISOR_INST_PLAZO 
    WHERE rut         = @Rut
      AND instrumento = @Instrumento
   SELECT @Cont = 1
   IF @Regs = 0
   BEGIN
      SELECT @Plazo_Limite = 1
      SET NOCOUNT OFF
      RETURN 
   END   
   WHILE @Cont <= @Regs
   BEGIN
      SET ROWCOUNT @Cont
      SELECT @Plazo_Ini = plazo_ini,
             @Plazo_Fin = plazo_fin
        FROM MD_EMISOR_INST_PLAZO 
       WHERE rut         = @Rut
         AND instrumento = @Instrumento
      SET ROWCOUNT 0
      SELECT @Cont = @Cont + 1
      IF @Plazo_Ini > @Plazo
      BEGIN
         SELECT @Plazo_Limite = @Plazo_Fin2 + 1
  SET NOCOUNT OFF
         RETURN
      END
      SELECT @Plazo_Ini2 = @Plazo_Ini
      SELECT @Plazo_Fin2 = @Plazo_Fin
         
   END
   SELECT @Plazo_Limite = @Plazo_Fin2 + 1
END
IF @Tipo_Limite = 'PFE' OR @Tipo_Limite = 'CCE'
BEGIN
   SELECT @Regs = COUNT(*) 
     FROM MD_PFE_CCE
    WHERE rut         = @Rut
      AND codigo      = @Codigo
      AND tipo_limite = @Tipo_Limite
      AND productos   = @Instrumento
   SELECT @Cont = 1
   IF @Regs = 0
   BEGIN
      SELECT @Plazo_Limite = 1
      SET NOCOUNT OFF
      RETURN 
   END   
   WHILE @Cont <= @Regs
   BEGIN
      SET ROWCOUNT @Cont
      SELECT @Plazo_Ini = Plazo_Ini,
             @Plazo_Fin = Plazo_Fin
        FROM MD_PFE_CCE
       WHERE rut         = @Rut
         AND codigo      = @Codigo
         AND tipo_limite = @Tipo_Limite
         AND productos   = @Instrumento
      SET ROWCOUNT 0
      SELECT @Cont = @Cont + 1
      IF @Plazo_Ini > @Plazo
      BEGIN
         SELECT @Plazo_Limite = @Plazo_Fin2 + 1
  SET NOCOUNT OFF
         RETURN
      END
      SELECT @Plazo_Ini2 = @Plazo_Ini
      SELECT @Plazo_Fin2 = @Plazo_Fin
         
   END
   SELECT @Plazo_Limite = @Plazo_Fin2 + 1
END
SET NOCOUNT OFF
END   

GO
