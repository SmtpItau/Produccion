USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_PasoInterfazSerie_Graba]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_PasoInterfazSerie_Graba]
      (   @Serie           CHAR(12)   
      ,   @emisor          NUMERIC(9) 
      ,   @fecha_emision   DATETIME
      ,   @tasa_emision    NUMERIC(10,4)   
      ,   @tasa_real       NUMERIC(10,4)   
      ,   @UM              CHAR(10)   
      ,   @BASE            NUMERIC(5)   
      ,   @Numero_Cupones  NUMERIC(5)     
      ,   @Perido_Pago     NUMERIC(5)     
      ,   @Estado          CHAR(10)   
      ,   @Terminal        CHAR(20)   
      )
AS
BEGIN
   
   SET DATEFORMAT dmy
   SET NOCOUNT ON

      INSERT INTO CARGA_INTERFAZ_SERIE
      (   Serie           
      ,   emisor          
      ,   fecha_emision   
      ,   tasa_emision    
      ,   tasa_real       
      ,   UM              
      ,   BASE            
      ,   Numero_Cupones  
      ,   Perido_Pago     
      ,   Estado          
      ,   Terminal        
      )
         VALUES
      (   @Serie           
      ,   @emisor          
      ,   @fecha_emision   
      ,   @tasa_emision    
      ,   @tasa_real       
      ,   @UM              
      ,   @BASE            
      ,   @Numero_Cupones  
      ,   @Perido_Pago     
      ,   @Estado          
      ,   @Terminal        
      )

END


GO
