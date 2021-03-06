USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CIERREMESA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CIERREMESA]  
AS  
BEGIN  
SET NOCOUNT ON  
 DECLARE @nivel CHAR(1)  
 DECLARE @msg   CHAR(100)  
   /*=======================================================================*/  
   /*=======================================================================*/  
   
   DECLARE @ccierremesa CHAR(01)  
   /*=======================================================================*/  
   /*=======================================================================*/  
   SELECT @ccierremesa = acsw_ciemefwd FROM MFAC
     
   /*=======================================================================*/  
   /*=======================================================================*/  

   IF EXISTS( SELECT * FROM lnkOpc.CbMdbOpc.dbo.OpcionesGeneral WHERE CierreMesa = 0 ) 
   BEGIN
     SELECT @nivel = '3'
     SELECT @msg = 'Cierre Mesa en SAO'     
   END
   ELSE
   BEGIN
   IF @ccierremesa = '1' BEGIN  
      /*====================================================================*/  
      /*====================================================================*/  
      UPDATE MFAC SET acsw_ciemefwd = '0', acsw_fd = '0', acsw_devenfwd = '0' ,acsw_contafwd = '0'  
      /*====================================================================*/  
      /*====================================================================*/  
 SELECT @nivel = '0'  
 SELECT @msg = 'Mesa Abierta'  
   /*=======================================================================*/  
   /*=======================================================================*/  
   END ELSE BEGIN  
      /*====================================================================*/  
      /*====================================================================*/  
      UPDATE MFAC SET acsw_ciemefwd = '1'   
      /*====================================================================*/  
      /*====================================================================*/  
 SELECT @nivel = '1'  
 SELECT @msg = 'Mesa Cerrada'  
   END  
   
   
	IF EXISTS( SELECT * FROM mfca WHERE caestado = 'P' OR caestado = 'R') 
		BEGIN  
			SELECT @nivel = '3'  
			SELECT @msg = 'Operaciones Con Problemas de Líneas'  
			
			UPDATE MFAC SET acsw_ciemefwd = '0', acsw_fd = '0', acsw_devenfwd = '0' ,acsw_contafwd = '0'  
		END  
    ELSE 
		BEGIN
		
		/*INI COMDER*/

				DECLARE @FECHA DATETIME
				SET		@FECHA  = (SELECT acfecproc FROM mfac WITH(NOLOCK))
			
				DECLARE @EXISTEN AS NUMERIC

				SET @EXISTEN = (SELECT COUNT(*) FROM bdbomesa..ComDer_SolicitudEstado se WITH(NOLOCK) INNER JOIN bdbomesa..ComDer_Solicitud s WITH(NOLOCK) ON
								s.numero_operacion = se.numero_operacion 
								WHERE se.id in
						(   SELECT MAX(id)FROM bdbomesa..ComDer_SolicitudEstado WITH(NOLOCK)
							WHERE CONVERT(VARCHAR(10), fecha, 112) = CONVERT(VARCHAR(10), @fecha, 112)
							GROUP BY numero_operacion
						)	AND id_estado in (1,2,3,4,5,7,8,9,12,13,14,15,16,17,18,19,20,21)
						AND s.sistema = 'BFW'
						) 
						
			IF (@EXISTEN > 0)
			BEGIN
			SELECT @nivel = '4'
				SELECT @msg = 'Existen operaciones pendientes y/o rechazadas en ComDer'
				UPDATE MFAC SET acsw_ciemefwd = '0', acsw_fd = '0', acsw_devenfwd = '0' ,acsw_contafwd = '0'
			END
			
		END   

		/*FIN COMDER*/
		
END 
 SELECT @nivel , @msg  
SET NOCOUNT OFF  
 

END



GO
