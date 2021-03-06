USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TXONLINE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SP_LEER_TXONLINE]
		( 	@Fecha		CHAR( 8) 	= ''  	,
			@Origen  	VARCHAR(20) 	= '' 	,
			@Numero  	NUMERIC(10) 	=  0 	,
			@indicador	CHAR(1)	    	= 'D'	)
AS
BEGIN

     SET NOCOUNT ON

     IF @origen ='BOLSA' 	
     BEGIN 	
         SELECT  Fecha                 , -- 1
                 Hora                  , -- 2
                 Origen                , -- 3
                 Numero                , -- 4
                 Codigo                , -- 5
                 Mercado               , -- 6
                 Tipo                  , -- 7
                 Moneda                , -- 8
                 MonedaCnv             , -- 9
                 Monto                 , -- 10
                 Precio                , -- 11
                 Equivalente           , -- 12
                 Rut                   , -- 13
                 'Dv'      = '0'       , -- 14
                 CodigoCliente         , -- 15
                 'Cliente' = SPACE(40) , -- 16
                 Contraparte           , -- 17
                 Contrausuario         , -- 18
                 Usuario               , -- 19
                 Estado                , -- 20
                 'EstadoGlosa' = (CASE WHEN estado = 'E' THEN 'Eliminada'  
                                   WHEN estado = 'P' THEN 'Pendiente' ELSE 'Aprobada' END), -- 21
                 Operacion             , -- 22. Numero de Operacion en movimiento del dia
                 'TipoCliente' = 0       -- 23                  
          INTO #txonline01
          FROM tbTXonline 
          WHERE ( origen    = @origen  OR @origen = '')
          AND   ( numero    = @numero  OR @numero =  0)
	  AND   ( indicador = @indicador )

     ----<< Carga datos del cliente, por seguridad en despliegue completo de datos
     UPDATE	#txonline01  
     SET 	tipocliente 	= cltipcli 	, 
		dv 		= cldv 		, 
		cliente 	= LEFT(clnombre,40)
     FROM 	view_cliente
     WHERE 	rut = clrut
     		AND codigocliente  = clcodigo     	
	     

     ----<< Resultado Final
     --IF @Fecha = ''  -- solo se necesita saber el total de registros
     --   SELECT 'Total' = COUNT(*) FROM #txonline01
     --ELSE  -- Devuelve consulta
        SELECT * FROM #txonline01 order by fecha, origen, numero
     END 

      ELSE
        BEGIN 	
         SELECT  Fecha                 , -- 1
                 Hora                  , -- 2
                 Origen                , -- 3
                 Numero                , -- 4
                 Codigo                , -- 5
                 Mercado               , -- 6
                 Tipo                  , -- 7
                 Moneda                , -- 8
                 MonedaCnv             , -- 9
                 Monto                 , -- 10
                 Precio                , -- 11
                 Equivalente           , -- 12
                 Rut                   , -- 13
                 'Dv'      = '0'       , -- 14
                 CodigoCliente         , -- 15
                 'Cliente' = SPACE(40) , -- 16
                 Contraparte           , -- 17
                 Contrausuario         , -- 18
                 Usuario               , -- 19
                 Estado                , -- 20
                 'EstadoGlosa' = (CASE WHEN estado = 'E' THEN 'Eliminada'  
                                   WHEN estado = 'P' THEN 'Pendiente' ELSE 'Aprobada' END), -- 21
                 Operacion             , -- 22. Numero de Operacion en movimiento del dia
                 'TipoCliente' = 0       -- 23
       INTO 	#txonline02
       FROM 	tbTXonline 
       WHERE 	(fecha   = @fecha   OR @fecha  = '')
             	AND (origen  = @origen  OR @origen = '')
             	AND (numero  = @numero  OR @numero =  0)
	     	AND   ( indicador = @indicador )
     ----<< Carga datos del cliente, por seguridad en despliegue completo de datos
     	
     UPDATE 	#txonline02 
  SET 	tipocliente = cltipcli , dv = cldv , cliente = LEFT(clnombre,40)
     FROM 	view_cliente
     WHERE 	rut 	= clrut
     		AND codigocliente  = clcodigo

     ----<< Resultado Final

     IF @Fecha = ''   -- solo se necesita saber el total de registros
        SELECT 'Total' = COUNT(*) FROM #txonline02 
       
     ELSE  -- Devuelve consulta
        SELECT * FROM #txonline02 order by fecha, origen, numero
     END		

END
GO
