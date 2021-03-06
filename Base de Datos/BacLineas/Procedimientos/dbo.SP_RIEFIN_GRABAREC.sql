USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_GRABAREC]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_GRABAREC]  
        (    @Fecha     datetime                  
      , @Rut     int       
      , @Codigo     int      
      , @Codigo_Metodologia  int  
      , @Nombre     VARCHAR(70)                                                                
      , @Linea     float                
      , @Treshold    float               
      , @Valor_Mercado   float         
      , @Exposicion_Maxima  float     
      , @VaR90D     float            
      , @AddOnAlVcto   float           
      , @Garantia_Ejecutada  CHAR(2)  
      , @Consumo_Linea   float          
      , @Holgura    float             
      , @Estado_Linea   varchar (50)      
        )  
  
  
   
AS  
BEGIN  
  
   SET NOCOUNT ON   
    
   BEGIN  
       -- Esta tabla registra siempre con 
       -- la fecha de ejecución.      
       select @fecha =  acfecproc from BacTraderSuda..Mdac
   
       delete TBL_RIEFIN_General_REC where Rut = @Rut and Codigo = @Codigo and fecha = @fecha
       -- select * from TBL_RIEFIN_General_REC
       if @Nombre = ''
          Select @Nombre = isnull( ( select substring( ClNombre , 1, 70 ) 
              from  BacParamSuda..Cliente 
                    where ClRut = @Rut 
                      and ClCodigo = @Codigo ) , 'No Existe en BAC'  )                                                                 


    INSERT INTO TBL_RIEFIN_General_REC  
    (    Fecha                     
  , Rut           
  , Codigo        
  , Codigo_Metodologia   
  , Nombre                                                                   
  , Linea                    
  , Treshold                 
  , Valor_Mercado            
  , Exposicion_Maxima        
  , VaR90D                   
  , AddOnAlVcto              
  , Garantia_Ejecutada   
  , Consumo_Linea            
  , Holgura                  
  , Estado_Linea  
  )  
    VALUES   
    (    @Fecha                     
  , @Rut           
  , @Codigo        
  , @Codigo_Metodologia   
  , @Nombre                                                                   
  , @Linea                    
  , @Treshold                 
  , @Valor_Mercado            
  , @Exposicion_Maxima        
  , @VaR90D                   
  , @AddOnAlVcto              
  , @Garantia_Ejecutada   
  , @Consumo_Linea            
  , @Holgura                  
  , @Estado_Linea         
    )  
   END   
END  

GO
