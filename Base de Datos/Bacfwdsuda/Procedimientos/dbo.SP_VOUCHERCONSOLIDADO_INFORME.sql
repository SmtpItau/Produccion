USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VOUCHERCONSOLIDADO_INFORME]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VOUCHERCONSOLIDADO_INFORME]
               (
                @cfecha CHAR(8)
               )
AS
BEGIN

 SET NOCOUNT ON
   DECLARE @entidad CHAR(40)

   SELECT @entidad = acnomprop 
     FROM MFAC

 IF EXISTS( SELECT 1
              FROM Centraliza_Voucher 
             WHERE @cfecha = FechaContable
          )

  BEGIN

   SELECT * ,@entidad
     FROM Centraliza_Voucher 
    WHERE @cfecha = FechaContable
    ORDER BY Folio_Perfil
    ,        Numero_Voucher
    ,        correlativo 

  END

 ELSE

  BEGIN

   SELECT Numero_Voucher    = 0
   ,      Correlativo       = 0
   ,      Cuenta            = ''
   ,      Glosa             = ''
   ,      Moneda_perfil     = 0
   ,      Folio_Perfil      = 0
   ,      Tipo_Monto        = ''
   ,      Monto             = 0
   ,      Moneda            = 0
   ,      Operacion         = 0
   ,      Nombre            = RTRIM(acnomprop)
   ,      Rut               = 0
   ,      Digito            = ''
   ,      ObsDia            = 0
   ,      UFDia             = 0
   ,      Nombre_Cliente    = ''
   ,      Direccion_Cliente = ''
   ,      Rut_Cliente       = 0
   ,      Digito_Cliente    = ''
   ,      Fecha_Proceso     = CONVERT(CHAR(10),acfecproc,103)
   ,      Glosa_Cuenta      = ''
   ,      Codigo_producto   = 0
   ,      Tipo_Mov          = ''
   ,      Fecha_Inicio      = ''
   ,      Fecha_Vcto        = ''
   ,      OP                = ''
   ,      T                 = ''
   ,      MonSuper          = 0 
   ,      fechacontable     = ''
   ,      @entidad
   FROM MFAC

  END

 SET NOCOUNT OFF
END

GO
