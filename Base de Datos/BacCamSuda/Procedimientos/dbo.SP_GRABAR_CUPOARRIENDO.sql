USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_CUPOARRIENDO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_CUPOARRIENDO] 
       (
        @usuario      CHAR(15),
        @terminal     CHAR(15),
        @fecha1       CHAR(8), -- proceso
        @Producto     CHAR(4),
        @MontoUSD     NUMERIC(19,4),
        @Cliente      CHAR(35),
        @rut          NUMERIC(9),
        @Codigo       NUMERIC(9),
        @operacion    CHAR(1),
        @precio       NUMERIC(19,4),
        @tipcambioC   NUMERIC(19,4),
        @tipcambioV   NUMERIC(19,4),
        @FormaPagoMxC NUMERIC(3),
        @FormaPagoMxV NUMERIC(3),
        @formaPagoMnC NUMERIC(3),
        @formaPagoMnV NUMERIC(3),
        @fechaVencimi CHAR(8),
        @Opcion       CHAR(2),         -- SI = para actualizar, NO = para insertar
        @cObservacion VARCHAR(250),    -- SI = para actualizar, NO = para insertar
        @numope       NUMERIC(07)
       )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @xnumoper  NUMERIC(7)
   DECLARE @xdias     NUMERIC(3)
   DECLARE @sum       NUMERIC(3)
   DECLARE @valuta1   DATETIME
   DECLARE @valuta2   DATETIME
   DECLARE @fecha     DATETIME
   SELECT @valuta1 = ' '
   SELECT @valuta2 = ' '
   SELECT @xdias   = 0 
   SELECT @fecha = CONVERT( CHAR(8), @fecha1, 112 )
   SELECT @xnumoper = accorope FROM meac
   IF @Producto = 'ARRI' BEGIN 
      IF @operacion = 'C' BEGIN 
         SELECT @xdias   = diasvalor FROM view_forma_de_pago WHERE codigo = @FormaPagoMxC
         SELECT @valuta1 = DATEADD( dw, @xdias, @fecha )
         SELECT @valuta2 = DATEADD( dw, @xdias, ( CONVERT( CHAR(8), @fechaVencimi, 112 ) ) )   -- " "
      END ELSE BEGIN
         SELECT @xdias   = diasvalor FROM view_forma_de_pago WHERE codigo = @FormaPagoMxV
         SELECT @valuta1 = DATEADD( dw, @xdias,@fecha)
         SELECT @valuta2 = DATEADD( dw, @xdias, ( CONVERT( CHAR(8), @fechaVencimi, 112 ) ) )   -- " "
      END
   END ELSE BEGIN    --Cupo
      IF @operacion = 'C' BEGIN 
         SELECT @xdias   = diasvalor FROM view_forma_de_pago WHERE codigo = @FormaPagoMxC
         SELECT @valuta1 = @fecha
         SELECT @valuta2 = DATEADD( dw, @xdias, @fecha )
      END ELSE BEGIN
         SELECT @xdias   = diasvalor FROM view_forma_de_pago WHERE codigo = @FormaPagoMxV
         SELECT @valuta1 = @fecha
         SELECT @valuta2 = DATEADD( dw, @xdias, @fecha )
      END
   END
   --<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   IF EXISTS( SELECT monumope FROM memo WHERE monumope = @numope ) AND @Opcion = 'SI' BEGIN
      UPDATE memo 
             SET   mooper             = @usuario,
                   moterm             = @terminal,
                   mohora             = CONVERT( CHAR(08), GETDATE(), 108 ),
                   mofech             = @fechavencimi,
                   motipmer           = @producto,
                   momonmo            = @montousd,
                   monomcli           = @cliente,
                   morutcli           = @rut,
                   mocodcli           = @codigo,
                   motipope           = @operacion,
                   moprecio           = @precio,
                   moticam            = @tipcambioc,
                   motctra            = @tipcambiov,
                   morecib            = @formapagomxc,
                   forma_pago_cli_ext = @formapagomxv,
                   moentre            = @formapagomnc,
                   forma_pago_cli_nac = @formapagomnv,
                   movaluta1          = @valuta1,
                   movaluta2          = @valuta2,
                   observacion        = @cobservacion
             WHERE monumope = @numope
                    
   END ELSE BEGIN
      UPDATE       meac
             SET   accorope  = (accorope + 1 )
      SELECT @numope = accorope FROM meac
      INSERT INTO memo 
                    (
                     moentidad,
                     mooper,
                     moterm,
                     mohora,
                     mofech,
                     motipmer,
                     momonmo,
                     monomcli,
                     morutcli,
                     mocodcli,
                     motipope,
                     moprecio,
                     moticam,
                     motctra,
                     morecib,
                     forma_pago_cli_ext,
                     moentre,
                     forma_pago_cli_nac,
                     movaluta1,
                     movaluta2,
                     monumope,
                     mocodmon,
                     mocodcnv,
                     id_sistema,
                     observacion
                    )
             VALUES (
                     1,
                     @usuario,
                     @terminal,
                     CONVERT( CHAR(08), GETDATE(), 108 ),     -- hora 
                     @fecha,     -- fecha
                     @producto,
                     @montousd,
                     @cliente,
                     @rut,
                     @codigo,
                     @operacion,
                     @precio,
                     @tipcambioc,
                     @tipcambiov,
                     @formapagomxc,
                     @formapagomxv,
                     @formapagomnc,
                     @formapagomnv,
                     @valuta1,
                     @valuta2,
                     @numope,
                     'USD',
                     'CLP',
                     'BCC',
                     @cobservacion
                    )
   END
   --<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   /* graba log si ocurre o no un error */
   IF @@ERROR <> 0 BEGIN
      EXECUTE sp_Grabar_Log 'BCC',@usuario,@Fecha,' No se Grabo En Forma Correcta CUPO,ARRIENDO'
      SELECT -1, 'ERROR:  NO SE GRABO EN FORMA CORRECTA.'
      SET NOCOUNT OFF
      RETURN
   END ELSE BEGIN
      EXECUTE sp_Grabar_Log 'BCC',@usuario,@Fecha,'Se Grabo En Forma Correcta CUPO,ARRIENDO'
   END
   SELECT @numope, @terminal
--   SET NOCOUNT OFF
END

GO
