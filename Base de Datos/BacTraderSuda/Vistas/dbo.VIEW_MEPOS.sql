USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MEPOS]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_MEPOS    fecha de la secuencia de comandos: 05/04/2001 9:20:54 ******/
CREATE VIEW [dbo].[VIEW_MEPOS]
AS
SELECT
vmcodigo ,
vmfecha   ,                  
vmposini   ,           
vmpreini    ,                                          
vmposic      ,         
vmtotco       ,        
vmpmeco        ,                                       
vmtotcous       ,      
vmtotcope        ,     
vmtotve           ,    
vmpmeve            ,                                   
vmtotveus           ,  
vmtotvepe            , 
vmutili               ,
vmprecierre            ,                               
vmparidad               ,                              
vmparcom                 ,                             
vmparven                                              
vmtotcopo             ,
vmpmecopo              ,                               
vmtotvepo             ,
vmpmevepo              ,                               
vmutilipo             ,
vmutiltot             ,
vmparmes                ,                              
vmpositini               ,                             
vmposition                ,                            
vmnegocio                 
FROM BACPARAMSUDA..POSICION_SPT

GO
