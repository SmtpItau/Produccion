USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICAR_FOLIO]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VERIFICAR_FOLIO]
               (@Numero_Imprimir  NUMERIC( 10)        )
AS
BEGIN
 DECLARE @Respuesta       CHAR   (70)
 DECLARE @Correla_Interno NUMERIC(19)
        DECLARE @Folio_Inicio    NUMERIC(19)
        DECLARE @Folio_Actual    NUMERIC(19)
        DECLARE @Folio_Termino   NUMERIC(19)
 DECLARE @Estado_Folio    CHAR   ( 1) 
 DECLARE @Estado          CHAR   ( 1) 
 DECLARE @Total_Folio     NUMERIC(19)
 DECLARE @Total_Folio2    NUMERIC(19)
 DECLARE @FOLIO           NUMERIC(19) 
 DECLARE @Total           FLOAT
 DECLARE @Total_Correla   INTEGER   
 DECLARE @I               INTEGER  
 SELECT @Total_Correla = COUNT(Correla_Interno) FROM BAC_TESORERIA_FOLIOS WHERE  estado = 'A' or Estado = 'N'
 
 SELECT @Correla_Interno = Correla_Interno ,
               @Folio_Inicio    = Folio_Inicio    ,
               @Folio_Actual    = Folio_Actual    ,
               @Folio_Termino   = Folio_Termino   ,       
        @Estado_Folio    = Estado   ,
        @Total_Folio     = (Folio_Termino - Folio_Actual) + 1
 FROM BAC_TESORERIA_FOLIOS WHERE estado = 'A'
 
 IF @Total_Folio < 0 
            SELECT @Total_Folio = 0  
  
  IF @Total_Folio > = @Numero_Imprimir  and @Estado_Folio = 'A' 
  begin
   
   SELECT @Respuesta = 'SI'
  end
  ELSE      
  BEGIN
   
    
   SELECT @I = 1
   SELECT @Total_Folio2 = 0 
    
   WHILE @Total_Correla > @I
   BEGIN    
    IF EXISTS(SELECT * FROM BAC_TESORERIA_FOLIOS WHERE Correla_Interno = @Correla_Interno + @I) 
    begin                         
     SELECT @Total_Folio2 = @Total_Folio2 + (SELECT  (Folio_Termino - Folio_Actual) + 1 FROM BAC_TESORERIA_FOLIOS WHERE Correla_Interno = @Correla_Interno + @I)              
     
     
     IF  @Total_Folio2 + @Total_Folio >= @Numero_Imprimir     
     begin
      SELECT @I = @Total_Correla
      SELECT @Respuesta = 'SI'
     end
     ELSE
     begin
      SELECT @I = @I + 1
      SELECT @Respuesta = 'NO'
     end 
    end
    ELSE
    begin
     SELECT @I = @I + 1
     SELECT @Respuesta = 'NO'    
    end
    
   END
  END
  SELECT @Respuesta 
END

GO
