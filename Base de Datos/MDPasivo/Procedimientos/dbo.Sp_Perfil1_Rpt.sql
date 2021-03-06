USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Perfil1_Rpt]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Perfil1_Rpt]
        (@id_sistema          CHAR(3)     =''  ,
	@codigo_producto      CHAR(5)     =''  ,
	@codigo_evento        CHAR(5)     =''  ,
        @codigo_moneda1       NUMERIC(5)  = 0  ,
        @codigo_moneda2       NUMERIC(5)  = 0  ,  
        @codigo_instrumento   CHAR(12)    ='' 
       )
AS
BEGIN
	SET DATEFORMAT dmy
	SET NOCOUNT ON
              SELECT      'hora_reporte'                      =  CONVERT(CHAR(10),GETDATE(),108)   
		     ,    'fecha_reporte'                     =  CONVERT(CHAR(10),GETDATE(),103) 	
                     ,    'campo'                             =  B.CODIGO_CAMPO
                     ,    'descripcion_campo'                 =  D.DESCRIPCION_CAMPO
                     ,    'tipo_monto'                        =  B.TIPO_MOVIMIENTO_CUENTA
                     ,    'perfil_fijo'                       =  B.PERFIL_FIJO
                     ,    'glosa_perfil'                      =  A.GLOSA_PERFIL
                     ,    'cuenta_perfil_si'                  =  B.CUENTA
                     ,    'descripcion_cuenta_perfil_si'      =  C.DESCRIPCION  

                     ,    'codigo_condicion'                  =  SPACE(10)
                     ,    'descripcion_condicion'             =  SPACE(100)
                     ,    'cuenta_perfil_no'                  =  SPACE(30)  
                     ,    'descripcion_cuenta_perfil_no'      =  SPACE(100)          

                     INTO #TMP 
                                                                                                        
               FROM       PERFIL                 A
                     ,    PERFIL_DETALLE         B
                     ,    PLAN_DE_CUENTA         C
                     ,    CAMPO                  D
                     ,    PERFIL_DETALLE         E
                     ,    CAMPO_LOGICO           F 
                     ,    PLAN_DE_CUENTA         G
                                                                                                                       
               WHERE      ( A.ID_SISTEMA          =  @id_sistema         OR @id_sistema         = ''  )
                      AND ( A.CODIGO_PRODUCTO     =  @codigo_producto    OR @codigo_producto    = ''  )    
                      AND ( A.CODIGO_EVENTO       =  @codigo_evento      OR @codigo_evento      = ''  )
                      AND ( A.CODIGO_MONEDA1      =  @codigo_moneda1     OR @codigo_moneda1     = 0   )
                      AND ( A.CODIGO_MONEDA2      =  @codigo_moneda2     OR @codigo_moneda2     = 0   )
                      AND ( A.CODIGO_INSTRUMENTO  =  @codigo_instrumento OR @codigo_instrumento = ''  )
                      AND ( B.ID_SISTEMA          =  A.ID_SISTEMA                                     )
                      AND ( B.CODIGO_PRODUCTO     =  A.CODIGO_PRODUCTO                                )      
                      AND ( B.CODIGO_EVENTO       =  A.CODIGO_EVENTO                                  )
                      AND ( B.CODIGO_MONEDA1      =  A.CODIGO_MONEDA1                                 )
                      AND ( B.CODIGO_MONEDA2      =  A.CODIGO_MONEDA2                                 )
                      AND ( B.CODIGO_INSTRUMENTO  =  A.CODIGO_INSTRUMENTO                             )   
                      AND   B.CUENTA              =  C.CUENTA  
                      AND   B.CODIGO_CAMPO        =  D.CODIGO_CAMPO 

                      UPDATE #TEMP SET
                            codigo_condicion              =      F.CODIGO_CONDICION
                      ,     descripcion_condicion         =      F.DESCRIPCION 
                      ,     cuenta_perfil_no              =      G.CUENTA 
                      ,     descripcion_cuenta_perfil_no  =      G.DESCRIPCION
                     
                      FROM #TEMP    

                     SELECT * FROM #TMP
                          
    SET NOCOUNT OFF


END




GO
