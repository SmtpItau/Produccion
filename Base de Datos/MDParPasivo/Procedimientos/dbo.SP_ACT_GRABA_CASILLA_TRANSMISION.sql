USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_GRABA_CASILLA_TRANSMISION]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ACT_GRABA_CASILLA_TRANSMISION](
                                                     @iNombre_host       Char(30)
                                                    ,@iDireccion_host    Char(30)
                                                    ,@iUsuario_host      Char(20)
                                                    ,@iClave_host        Char(20)
                                                    ,@iPath_inicial_host Char(50)
                                                )
AS
BEGIN --INICIO SP

	SET DATEFORMAT DMY
	SET NOCOUNT ON


    IF EXISTS( SELECT * FROM CASILLA_TRANSMISION WHERE @iNombre_Host = Nombre_Host ) BEGIN
        
        UPDATE CASILLA_TRANSMISION SET   Nombre_host         = @iNombre_Host           
                                        ,Direccion_host      = @iDireccion_Host
                                        ,Usuario_host        = @iUsuario_Host
                                        ,Clave_host          = @iClave_Host
                                        ,Path_inical_host    = @iPath_Inicial_Host
        WHERE @iNombre_Host = Nombre_Host   

    END ELSE BEGIN
        
        INSERT CASILLA_TRANSMISION VALUES(  ' '
                                            ,@iNombre_Host           
                                           ,@iDireccion_Host
                                           ,@iUsuario_Host
                                           ,@iClave_Host
                                           ,@iPath_Inicial_Host 
                                         )

    END

END --FIN SP

GO
