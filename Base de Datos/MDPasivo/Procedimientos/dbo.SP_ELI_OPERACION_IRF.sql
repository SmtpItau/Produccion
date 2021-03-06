USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_OPERACION_IRF]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELI_OPERACION_IRF]
                                            @nnumero_operacion        NUMERIC(10) = 0
                                        ,   @cusuario_anula           CHAR(15)    = ''
                                        ,   @ndeskmngr_keyid          NUMERIC(09) = 0
AS
BEGIN
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED
    SET NOCOUNT ON
    SET DATEFORMAT dmy

    DECLARE @codigo_producto        CHAR(05)
           ,@rut_entidad            NUMERIC(09)

    DECLARE @cmen char(255)
    SELECT @codigo_producto = ''
    SELECT @cmen = ''

    SELECT @rut_entidad = rut_entidad
        FROM VIEW_DATOS_GENERALES

    IF @nnumero_operacion = 0 AND @ndeskmngr_keyid = 0
        SELECT nCodigo = -1, cDescripcion = 'Debe por lo menos ingresar un numero de operacion para anular', cProducto = @codigo_producto

    SET ROWCOUNT 1
        IF @nnumero_Operacion  = 0
            SELECT @nnumero_operacion = monumoper
                    FROM MOVIMIENTO_TRADER WITH (NOLOCK) WHERE keyid_desk_manager = @ndeskmngr_keyid

        SELECT @codigo_producto = motipoper
        FROM MOVIMIENTO_TRADER WITH (NOLOCK),VIEW_DATOS_GENERALES
        WHERE monumoper = @nnumero_operacion
        AND   mofecpro  = fecha_proceso

    SET ROWCOUNT 0

	IF EXISTS(SELECT blnumdocu,monumoper,moinstser FROM DOCUMENTO_BLOQUEADO WITH (NOLOCK), MOVIMIENTO_TRADER WITH (NOLOCK)
		  WHERE monumoper = @nnumero_operacion and blnumdocu= monumdocu AND   mocorrela = blcorrela)
	BEGIN
		SELECT nCodigo = -1, cDescripcion = 'Operacion tiene documentos bloqueados para venta.', cProducto = @codigo_producto
		RETURN
	END 

    IF @codigo_producto NOT IN('IB','TD','LBC', 'FPD') BEGIN

	IF @codigo_producto = 'CP' 	EXECUTE Sp_Eliminacp  @nnumero_operacion, @rut_entidad, @cmen OUTPUT
	IF @codigo_producto = 'VP' 	EXECUTE Sp_Eliminavp  @nnumero_operacion, @rut_entidad, @cmen OUTPUT
	IF @codigo_producto = 'CI' or @codigo_producto = 'CIX' 	EXECUTE Sp_Eliminaci  @nnumero_operacion, @rut_entidad, @cmen OUTPUT
	IF @codigo_producto IN ('VI','VIX','FLI','FLP','RP') EXECUTE Sp_Eliminavi  @nnumero_operacion, @rut_entidad, @cmen OUTPUT
	IF @codigo_producto = 'SLH'	EXECUTE Sp_EliminaSLH @nnumero_operacion, @rut_entidad, @cmen OUTPUT
	IF @codigo_producto = 'RFM'	EXECUTE SP_ELI_ANULACION_FM  @nnumero_operacion, @codigo_producto, @cmen OUTPUT
	IF @codigo_producto = 'CFM'	EXECUTE SP_ELI_ANULACION_FM  @nnumero_operacion, @codigo_producto, @cmen OUTPUT
	IF @codigo_producto = 'RCA' 	EXECUTE Sp_ELI_RECOMPRA_ANTICIPADA  @nnumero_operacion, @rut_entidad, @cmen OUTPUT
	IF @codigo_producto = 'RVA'	EXECUTE Sp_ELI_REVENTA_ANTICIPADA @nnumero_operacion, @rut_entidad, @cmen OUTPUT
	IF @codigo_producto = 'TI'	EXECUTE Sp_Eli_TRASPASO_CARTERA  @nnumero_operacion, @rut_entidad, @cmen OUTPUT

    END
    ELSE BEGIN
        IF @codigo_producto = 'IB' OR @codigo_producto = 'FPD'
            EXECUTE SP_ANULAINTERBANCARIO @nnumero_operacion, @cmen OUTPUT
        IF @codigo_producto = 'TD'
            EXECUTE SP_ANULATIMEDEPOSIT @nnumero_operacion,@cmen OUTPUT
        IF @codigo_producto = 'LBC'
            EXECUTE SP_ANULALINEABANCOCENTRAL @nnumero_operacion,@cmen OUTPUT
    END



        UPDATE MOVIMIENTO_TRADER WITH (ROWLOCK) SET moimpreso = '' 
         WHERE monumoper = @nnumero_operacion
           AND morutcart = @rut_entidad


        UPDATE VIEW_VALE_VISTA_EMITIDO WITH (ROWLOCK) SET documento_estado = 'A'
         WHERE codigo_producto  = @codigo_producto
           AND numero_operacion = @nnumero_operacion


    SET NOCOUNT OFF

    IF @cmen <> '' 
       SELECT nCodigo = -1, cDescripcion = @cmen, cProducto = @codigo_producto
    ELSE 
       SELECT nCodigo = 0, cDescripcion = 'Operacion anulada correctamente', cProducto = @codigo_producto
END

GO
