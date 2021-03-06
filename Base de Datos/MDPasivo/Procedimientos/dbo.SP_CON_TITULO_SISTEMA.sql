USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TITULO_SISTEMA]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_TITULO_SISTEMA]
               ( @cId_Sistema   CHAR(03)
               , @cVersion      VARCHAR(10)
               )
AS
BEGIN
 
   SET NOCOUNT ON
   SET DATEFORMAT dmy
 
   SELECT @cVersion = REPLACE(@cVersion,'_','')
 
   DECLARE @cSistema   VARCHAR(30)
         , @cSistema_V VARCHAR(30)
         , @nCaracter  INTEGER
         , @cPrimer    CHAR(1)
 
    SELECT @cSistema     = nombre_sistema
         , @nCaracter    = 1
         , @cPrimer      = 'S'
         , @cSistema_V   = ' '
      FROM SISTEMA
     WHERE id_sistema    = @cId_Sistema
  
 

     WHILE @nCaracter <= LEN(@cSistema)
     BEGIN
 
         IF @cPrimer = 'S'  BEGIN
            SELECT @cSistema_V = @cSistema_V + UPPER( SUBSTRING(@cSistema,@nCaracter,1) )
                 , @cPrimer = 'N'
 
         END ELSE
         BEGIN
 
            IF SUBSTRING(@cSistema,@nCaracter -1,1) = ' ' 
               SELECT @cSistema_V = @cSistema_V + UPPER( SUBSTRING(@cSistema,@nCaracter,1) )
 
            ELSE 
               SELECT @cSistema_V = @cSistema_V + LOWER( SUBSTRING(@cSistema,@nCaracter,1) )   
 
         END
 
         SET @nCaracter = @nCaracter +1 
     END
 
   
     IF NOT ISNULL(@cSistema_V,' ') = ' ' 
        SELECT @cSistema_V + ' ' + @cVersion
 
     ELSE
        SELECT 'NO ESTABLECIDO'
 
   SET NOCOUNT OFF
 
END
 



GO
