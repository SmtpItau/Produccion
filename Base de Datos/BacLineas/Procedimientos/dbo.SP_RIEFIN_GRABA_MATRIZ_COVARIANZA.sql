USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_GRABA_MATRIZ_COVARIANZA]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_GRABA_MATRIZ_COVARIANZA]   
(  @Fila       NUMERIC (9,0)  
 , @Columna    NUMERIC (9,0)  
 , @Valor      float  
 , @Nombre     VARCHAR(100)   
 , @Fecha      datetime  
 , @Tamanno    Numeric(9,0)  
)   
AS  
BEGIN  
  
   SET NOCOUNT ON  
     
   Begin  
       Insert into RIEFIN_Matriz_Covarianza   
       select @Fila, @Columna, @Valor, @Nombre , @fecha  , @Tamanno  
   End   
 
END  

GO
