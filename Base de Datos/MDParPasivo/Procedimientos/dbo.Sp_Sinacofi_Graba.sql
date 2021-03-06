USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Sinacofi_Graba]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Sinacofi_Graba]
            (  
                  @clrut         numeric(10) ,
                  @clcodigo      numeric(10) ,
                  @clnumsinacofi char(4)     ,
                  @clnomsinacofi char(10)    ,
                  @datatec       char(30)    ,
                  @bolsa         char(10)    ,
                  @cuenta_dcv    char(8)     ,
                  @nombre_datatec char(30)
            )
AS 
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON
   
   IF NOT EXISTS(SELECT 1 FROM SINACOFI 
                     where clrut    = @clrut 
                       and clcodigo = @clcodigo
                )
   BEGIN 

      INSERT INTO SINACOFI( clrut
                           ,clcodigo
                           ,clnumsinacofi
                           ,clnomsinacofi
                           ,datatec
                           ,bolsa
                           ,cuenta_dcv
			   ,Nombre_cliente_datatec
                          )
                    VALUES( @clrut
                           ,@clcodigo
                           ,@clnumsinacofi
                           ,@clnomsinacofi
                           ,@datatec
                           ,@bolsa
                           ,@cuenta_dcv
			   ,@nombre_datatec
                          )
   END ELSE BEGIN

        UPDATE SINACOFI SET clrut         = @clrut
                           ,clcodigo      = @clcodigo
                           ,clnumsinacofi = @clnumsinacofi
                           ,clnomsinacofi = @clnomsinacofi
                           ,datatec       = @datatec
                           ,bolsa         = @bolsa
                           ,cuenta_dcv    = @cuenta_dcv
			   ,Nombre_cliente_datatec = @nombre_datatec
                        WHERE clrut = @clrut and clcodigo = @clcodigo

   END

END


GO
