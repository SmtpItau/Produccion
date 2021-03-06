USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_DIRECCIONES_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_DIRECCIONES_SWAP]
AS
BEGIN

-- Swap: Guardar Como
	SET NOCOUNT ON
	DECLARE	@Cuenta            	VARCHAR(20)
		,@Tipo_Monto        	CHAR(1)
		,@Numero_Voucher    	NUMERIC(9)
		,@Correlativo       	NUMERIC(5)
		,@Moneda            	NUMERIC(5)
		,@Monto             	FLOAT
		,@Operacion         	NUMERIC(9)
		,@Tipo_Operacion	CHAR(5)
		,@Glosa             	CHAR(70)
		,@Tipo_Voucher      	CHAR(1)
		,@Numero            	NUMERIC(5)
		,@x                 	INTEGER
		,@num_oper          	NUMERIC(9)
		,@tip_oper          	CHAR(3)
		,@cod_pro           	CHAR(4)
		,@T_prod            	CHAR(4)
		,@max               	INTEGER
		,@FECHA             	DATETIME
		,@vDolar_obs        	NUMERIC(18,2)
		,@vUF               	NUMERIC(18,2)
		,@cal_monto         	NUMERIC(18,2)
		,@signo             	CHAR(1)
		,@T_monto           	CHAR(1) 
		,@cMoneda		NUMERIC(3)
		,@registros		INTEGER

	SELECT 	@fecha      = fechaproc FROM SwapGeneral
	SELECT 	@vDolar_obs = ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = 994 and vmfecha = @fecha),0)
	SELECT 	@vUF        = ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = 998 and vmfecha = @fecha),0)

	CREATE TABLE #NEOSOFT
	(	
		I_cliente		VARCHAR(12)
		,D_cliente		CHAR(1)
		,F_Producto        	CHAR(4)     ---MD01
		,T_Producto          	CHAR(4)     ---MDIR
		,Nro_Operacion     	VARCHAR(20)
		,D_despacho		VARCHAR(40)
		,D_despacho1		VARCHAR(40)
		,Comuna			VARCHAR(8)
		,Ciudad			VARCHAR(8)
		,Fono			VARCHAR(11)
		,F_ultima_act		DATETIME
		,Registros		INTEGER
	)                  
SET NOCOUNT ON


        SELECT ope = Numero_Operacion 
        ,      flu = MIN(numero_flujo) 
        ,      tip = MIN(tipo_flujo)
        INTO   #DEVENGAMIENTO   
        FROM   CARTERA where Estado <> 'C'
        GROUP BY Numero_Operacion 


	INSERT INTO #NEOSOFT
	SELECT DISTINCT
         'I_cliente'       = CONVERT(CHAR(12),b.clrut)
         ,'D_cliente'      = b.Cldv
         ,'F_Producto'     = 'MDIR'
         ,'T_Producto'     = 'MD01'
         ,'Nro_Operacion'  = numero_operacion --CONVERT(VARCHAR(10),numero_operacion)+ CONVERT(VARCHAR(5),numero_flujo) + CONVERT(VARCHAR(1), tipo_flujo)
         ,'D_despacho'     = ISNULL(LEFT(B.Cldirecc,40),'')
	 ,'D_despacho1'	   = Space(40)
         ,'Comuna'         = ISNULL(CONVERT(VARCHAR(8),B.Clcomuna),0)
         ,'Ciudad'         = ISNULL(CONVERT(VARCHAR(8),B.Clciudad),0)
         ,'Fono'           = ISNULL(substring(replace(B.Clfono,' ',''),1,11),'0')
         ,'F_ultima_act'   = B.Clfeculti
         ,'Registros'      = 0
 	FROM    CARTERA	
                INNER JOIN #DEVENGAMIENTO          ON ope     = Numero_Operacion AND flu        = numero_flujo AND tip = tipo_flujo
                LEFT  JOIN BacParamSuda..CLIENTE b ON b.clrut = rut_cliente      AND b.clcodigo = codigo_cliente
        WHERE (fecha_cierre               >= @Fecha
           OR  fecha_vence_flujo          >= @Fecha)
        AND    Fecha_Termino               > @Fecha --> Quita el Registro del Día del Vcto General.
        AND    Tipo_flujo                  = 1
        and    estado                     <> 'C'


       	SELECT @max = COUNT(1) FROM #NEOSOFT

	UPDATE #NEOSOFT
	SET    Registros = @max

	UPDATE #NEOSOFT
	SET    Fono = '0'
	WHERE  Fono = ''

	UPDATE #NEOSOFT
	SET    Comuna = '9999'
	WHERE  Comuna = '0'

	UPDATE #NEOSOFT
	SET    Ciudad = '9999'
	WHERE  Ciudad = '0'

	SELECT * FROM #NEOSOFT

END
GO
