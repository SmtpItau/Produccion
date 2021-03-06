USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAGOCAPTACION]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PAGOCAPTACION]
               ( @nnumoper numeric(10,0) , @correla NUMERIC(10) )
AS
BEGIN
SET NOCOUNT ON
 DECLARE @dfecpro DATETIME 
 DECLARE @ibase  INTEGER 
 DECLARE @iEstado INTEGER 
 DECLARE @nRut_Cliente   NUMERIC(10)
 DECLARE @nCodigo_Rut    NUMERIC(5)
 DECLARE @cFormaPago CHAR(4)
 DECLARE @cRetiro CHAR(1)
 DECLARE @nMonto         FLOAT
 DECLARE @nEntidad       NUMERIC(10)
 DECLARE @cMoneda CHAR(3)
 SELECT @nentidad = acrutprop from mdac 
 IF NOT EXISTS( SELECT * FROM GEN_CAPTACION WHERE  numero_operacion = @nnumoper AND  Correla_operacion = @correla) 
 BEGIN
  SELECT 'NO', 'PROBLEMAS EN EL PAGO DE CAPTACIONES'
  SET NOCOUNT OFF
  RETURN
 END
 BEGIN TRANSACTION
 
     /* 
 ====================================================================
 Cambio estado de operacion de vigente a operacion pagada 
 ==================================================================== */
 UPDATE GEN_CAPTACION SET estado ='P' WHERE numero_operacion  = @nnumoper AND  Correla_operacion = @correla
     /* ====================================================================  */
 IF @@ERROR<> 0
 BEGIN
  ROLLBACK TRANSACTION
  SELECT 'NO',  'PROBLEMAS EN ACTUALIZACI¢N DE ESTADO DE LAS CAPTACIONES'
  SET NOCOUNT OFF
  RETURN
 END
 SELECT @ibase = mnbase FROM VIEW_MONEDA, GEN_CAPTACION  WHERE mncodmon = moneda  and numero_operacion = @nnumoper AND  Correla_operacion = @correla
 SELECT @dfecpro = acfecproc FROM mdac  
 /* Rescata datos de la Operacion */
 SELECT  @nRut_Cliente = Rut_Cliente,
  @nCodigo_Rut  = Codigo_Rut,
  @cFormaPago   = Forma_Pago,
  @cRetiro      = Retiro,
  @nMonto       = Valor_Presente,
  @cMoneda      = (CASE WHEN Moneda = 13 THEN 'USD' ELSE '$$' END)
 FROM GEN_CAPTACION
 WHERE numero_operacion = @nnumoper
 AND  Correla_operacion = @correla
/*     Execute @iEstado = Sp_Graba_Operacion_Tesoreria 'BTR'  ,
              @dFecpro ,
       'VIC'  ,
       @nNumoper ,
       @nRut_Cliente ,
       @nCodigo_Rut ,
       @nMonto  ,
       @cMoneda ,
       'S'  ,
       @cFormaPago ,
       'V'  ,
       @nEntidad ,
       ''  ,
       0.0  ,
       ''  ,
       @correla
 IF @iEstado <> 0 BEGIN
     ROLLBACK TRANSACTION
  
     SELECT 'NO', 'Error: Error: En la Grabacion de Tesoreria'
       RETURN
 END*/
 COMMIT TRANSACTION  
 SELECT 'SI', 'PAGO DE CAPTACION REALIZADO CORRECTAMENTE'
 SET NOCOUNT OFF
END
-- select estado,* from gen_captacion where numero_operacion = 14
-- SP_HELPTEXT Sp_Graba_Operacion_Tesoreria 
-- select * from gen_operaciones

GO
