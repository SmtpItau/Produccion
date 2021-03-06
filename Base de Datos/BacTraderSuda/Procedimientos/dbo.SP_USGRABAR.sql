USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_USGRABAR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_USGRABAR]
                            ( @usuario1   CHAR    (15),
                              @nombre1    CHAR    (40),
                              @password1  CHAR    (15),
                              @fechaexp1   DATETIME)
AS 
BEGIN 
      IF EXISTS(SELECT usuario FROM BACUSER WHERE usuario = @usuario1)
         UPDATE
           BACUSER
         SET
           usuario  = @usuario1 ,
           nombre   = @nombre1  ,
           password = @password1,
           fechaexp = @fechaexp1
         WHERE   
           usuario  = @usuario1
      ELSE
         INSERT 
           INTO
         BACUSER
           (
            usuario ,
            nombre  , 
            password, 
            fechaexp 
           )
         VALUES 
           (
            @usuario1 ,
            @nombre1  , 
            @password1, 
            @fechaexp1 
           )
      RETURN
END

GO
