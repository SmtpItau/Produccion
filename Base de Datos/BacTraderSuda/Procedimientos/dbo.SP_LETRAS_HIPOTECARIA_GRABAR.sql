USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LETRAS_HIPOTECARIA_GRABAR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LETRAS_HIPOTECARIA_GRABAR]
                      (    
                        @rut_cliente      NUMERIC  (09,0),
                        @dv_cliente       CHAR     (01),
                        @codigo_cliente   NUMERIC  (09,0),
                        @nombre_cliente   CHAR     (60),
                        @direc_cliente    CHAR     (40),
                        @telefono_cliente CHAR     (30),
                        @fax_cliente      CHAR     (20),
                        @email_cliente    CHAR     (40),
                        @codigo_pais   NUMERIC  (05,0) ,
                        @codigo_region   NUMERIC  (05,0),
                        @codigo_ciudad   NUMERIC  (05,0) ,
                        @codigo_comuna   NUMERIC  (05,0)   )
AS
BEGIN
   
        SET NOCOUNT ON
              
        IF EXISTS (SELECT rut_cliente FROM LETRA_HIPOTECARIA_CLIENTE WHERE rut_cliente =@rut_cliente
                                                                             and dv =@dv_cliente
                                                                             and codigo_cliente =@codigo_cliente ) BEGIN
        UPDATE LETRA_HIPOTECARIA_CLIENTE
        SET             rut_cliente=@rut_cliente,
                        dv=@dv_cliente,
                        codigo_cliente=@codigo_cliente,
                        nombre=@nombre_cliente,
                        direccion=@direc_cliente,
                        telefono=@telefono_cliente,
                        fax=@fax_cliente,
                        email=@email_cliente,
                        codigo_pais=@codigo_pais,
                        codigo_region=@codigo_region,
                        codigo_ciudad=@codigo_ciudad,
                        codigo_comuna=@codigo_comuna
        WHERE  rut_cliente=@rut_cliente and dv=@dv_cliente and codigo_cliente=@codigo_cliente
        END
  ELSE BEGIN
        INSERT LETRA_HIPOTECARIA_CLIENTE
                (        rut_cliente,
                         codigo_cliente,
                         dv,
                         nombre,
                         direccion,
                         telefono,
                         fax,
                         email,
                         codigo_pais,
                         codigo_region,
                         codigo_ciudad,
                         codigo_comuna
               )
        VALUES
               (
                         @rut_cliente,
                         @codigo_cliente,
                         @dv_cliente,
                         @nombre_cliente,
                         @direc_cliente,
                         @telefono_cliente,
                         @fax_cliente,
                         @email_cliente,
                         @codigo_pais,
                         @codigo_region,
                         @codigo_ciudad,
                         @codigo_comuna
               )            
END
SET NOCOUNT OFF
SELECT 'OK'                                                                                                                                                                                                                                                    
                                                                                                         
END


GO
