USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDACINICIODIA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDACINICIODIA] ( @cFecproc CHAR ( 10 ),  
                                    @cFecprox CHAR ( 10 )  
                                  )  
AS  
BEGIN  
     
   SET NOCOUNT ON  
 DECLARE @fecha_ayer DATETIME  
 SELECT  @fecha_ayer = acfecproc  
 FROM  mfac  
  
   UPDATE MFAC   
   SET  acfecante     = @fecha_ayer      ,  
        acfecproc     = CONVERT( DATETIME, @cFecproc, 101 ),  
        acfecprox     = CONVERT( DATETIME, @cFecprox, 101 ),  
        acsw_pd       = '1'       ,  
        acsw_ciemefwd = '0'       ,  
        acsw_fd       = '0'       ,  
  acsw_contafwd = '0'       ,  
        acsw_devenfwd = '0'         
  
 UPDATE  BACLINEAS..matriz_atribucion_instrumento   
 SET Acumulado_Diario = 0  
-- SELECT * FROM BACLINEAS..matriz_atribucion_instrumento   
 WHERE  Id_Sistema = 'BFW'  
  
   SET NOCOUNT OFF  
   SELECT 0  
END  
GO
