USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLIENTE_TURING]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LEER_CLIENTE_TURING] (   
                                  @Rut     NUMERIC(9) =  0 ,  
                                  @Codigo  NUMERIC(9) =  0 ,
								  @Tipocli NUMERIC(9) =  -1, 	
                                  @Nombre  CHAR(40)   = '' )  -- Generico del Cliente
AS
BEGIN

     SET NOCOUNT ON
     SELECT     clrut                                ,  -- 1
                cldv                                 ,  -- 2
                clcodigo                             ,  -- 3
                clnombre                             ,  -- 4
                cldirecc                             ,  -- 5
                clcomuna                             ,  -- 6
                CONVERT( CHAR(10), clfecingr, 103 ) AS clfecingr  ,  -- 7
                clfono                               ,  -- 8
                clfax                                ,  -- 9
                cltipcli                             ,  -- 10
				clciudad                             ,  -- 11
                clmercado                            ,  -- 12
                clpais                               ,  -- 13
				fecha_escritura                      ,  -- 14
				nombre_notaria 						 ,  -- 15   
				clFechaFirma_cond
      ,			'COMUNA'	= ISNULL((SELECT	nombre 
       			        	          FROM		BACPARAMSUDA..COMUNA 
       			        	          WHERE		codigo_comuna = ISNULL(CLIENTE.Clcomuna,'') 
									  AND		codigo_ciudad = ISNULL(CASE WHEN CLIENTE.Clcomuna = 3201 THEN 3201 
																	   ELSE CLIENTE.Clciudad END,'')),'')
      ,			'CIUDAD'	= ISNULL((SELECT	nombre 
       			        	          FROM		BACPARAMSUDA..CIUDAD
									  WHERE		codigo_ciudad	=  ISNULL(CASE WHEN CLIENTE.Clcomuna = 3201 THEN 3201 
																		  ELSE CLIENTE.Clciudad END,'')),'')
	  ,			NUEVO_CCG_FIRMADO
	  ,			CONVERT(CHAR(10),FECHA_FIRMA_NUEVO_CCG,103) AS FECHA_FIRMA_NUEVO_CCG
	  ,			'THRESHOLD' =	ISNULL ((	select Monto_Linea_Threshold
											from BacLineas..linea_General 
											where Rut_cliente = @Rut and Codigo_Cliente = @Codigo),0)
									
	  ,			'METODOLOGIA' =	 ISNULL(Baclineas.dbo.FN_RIEFIN_METODO_LCR( @Rut, @Codigo, @Rut, @Codigo ),1)  
	  FROM  bacparamsuda..cliente CLIENTE
      WHERE (clrut    = @Rut    OR @Rut    =  0 )
      AND	(clcodigo = @Codigo OR @Codigo =  0 )
      AND	(cltipcli = @Tipocli OR @Tipocli =  -1 )
      AND	(clnombre > @Nombre OR @Nombre = '')
	  AND	(clvigente = 'S')
      ORDER BY clnombre
END

GO
