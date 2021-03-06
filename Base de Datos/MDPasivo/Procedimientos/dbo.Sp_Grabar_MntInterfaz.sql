USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Grabar_MntInterfaz]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_Grabar_MntInterfaz]
              (   
                  @sistema            CHAR        (3)
                , @codinterfaz        CHAR        (30)
                , @rutentidad         NUMERIC     (9)
                , @descinterfaz       VARCHAR     (50) 
                , @rutaacceso         VARCHAR     (100)
                , @tipointerfaz       CHAR        (01)
                , @cartera            CHAR        (10)
                , @nombre             CHAR        (20)
                , @Diaria             NUMERIC     (1)    --9
                , @Dias               CHAR        (40)    --10
                , @Mensual            NUMERIC     (1)    --11
                , @Casilla            CHAR        (30)    --12
                , @Nemotecnico        NUMERIC     (1)    --13
                , @Path_Inicio        CHAR        (100)    --14
                , @Archivo_Inicio     CHAR        (20)    --15
                , @Fijo_Inicio        CHAR        (15)    --16
                , @Fecha_Inicio       CHAR        (15)    --17
                , @Extencion_Inicio   CHAR        (15)    --18
                , @Path_Final         CHAR        (100)    --19
                , @Archivo_Final      CHAR        (20)    --20
                , @Fijo_Final         CHAR        (15)    --21
                , @Fecha_Final        CHAR        (15)    --22
                , @Extencion_Final    CHAR        (15)    --23
               )
AS           
BEGIN
      SET NOCOUNT ON 
      SET DATEFORMAT dmy


      IF @cartera = 'E' BEGIN
         DELETE INTERFAZ 
          WHERE  id_sistema      = @sistema  
            and  rut_entidad     = @rutentidad 
         
         SELECT 'ELIMINACION'
         RETURN  
      
      END
      IF RIGHT(RTRIM(@Dias),1) = "." BEGIN
         SELECT @Dias  =LEFT(RTRIM(@DIAS),LEN(@Dias)-1)
         SELECT @Dias  =REPLACE(@DIAS,".",",")
      END 


IF EXISTS (SELECT codigo_interfaz FROM INTERFAZ 
           WHERE  codigo_interfaz = @codinterfaz
           and    id_sistema      = @sistema  
           and    codigo_cartera  = @cartera  
           and    rut_entidad     = @rutentidad            )
BEGIN

      UPDATE   INTERFAZ 
      SET      descripcion        = @descinterfaz
            ,  ruta_acceso        = @rutaacceso
            ,  tipo_interfaz      = @tipointerfaz
            ,  nombre             = @nombre       
            ,  Diaria             = @Diaria
            ,  Dias               = @Dias
            ,  Mensual            = @Mensual            
            ,  Casilla            = @Casilla            
            ,  Nemotecnico        = @Nemotecnico        
            ,  Path_Inicio        = @Path_Inicio        
            ,  Archivo_Inicio     = @Archivo_Inicio     
            ,  Fijo_Inicio        = @Fijo_Inicio        
            ,  Fecha_Inicio       = @Fecha_Inicio       
            ,  Extencion_Inicio   = @Extencion_Inicio   
            ,  Path_Final         = @Path_Final         
            ,  Archivo_Final      = @Archivo_Final      
            ,  Fijo_Final         = @Fijo_Final         
            ,  Fecha_Final        = @Fecha_Final        
            ,  Extencion_Final    = @Extencion_Final    
            
      WHERE    codigo_interfaz    = @codinterfaz
      and      id_sistema         = @sistema  
      and      codigo_cartera     = @cartera  
      and      rut_entidad        = @rutentidad 


END ELSE 
BEGIN

      INSERT  INTERFAZ
               (
                   id_sistema
               ,   codigo_interfaz
               ,   rut_entidad
               ,   descripcion
               ,   ruta_acceso
               ,   tipo_interfaz
               ,   codigo_cartera
               ,   nombre
               ,   Diaria             
               ,   Dias               
               ,   Mensual            
               ,   Casilla            
               ,   Nemotecnico        
               ,   Path_Inicio        
               ,   Archivo_Inicio     
               ,   Fijo_Inicio        
               ,   Fecha_Inicio       
               ,   Extencion_Inicio   
               ,   Path_Final         
               ,   Archivo_Final      
               ,   Fijo_Final         
               ,   Fecha_Final        
               ,   Extencion_Final    

               )

      VALUES
               (
                   @sistema
               ,   @codinterfaz
               ,   @rutentidad
               ,   @descinterfaz
               ,   @rutaacceso
               ,   @tipointerfaz
               ,   @cartera
               ,   @nombre
               ,   @Diaria             
               ,   @Dias               
               ,   @Mensual            
               ,   @Casilla            
               ,   @Nemotecnico        
               ,   @Path_Inicio        
               ,   @Archivo_Inicio     
               ,   @Fijo_Inicio        
               ,   @Fecha_Inicio       
               ,   @Extencion_Inicio   
               ,   @Path_Final         
               ,   @Archivo_Final      
               ,   @Fijo_Final         
               ,   @Fecha_Final        
               ,   @Extencion_Final    


               )
END

SET NOCOUNT OFF

   SELECT 'OK'

END





GO
