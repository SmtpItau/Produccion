USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FRMLETRASHIPOTECARIAS_GRABA_CORTES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FRMLETRASHIPOTECARIAS_GRABA_CORTES]
            (
             @codigo_planilla      NUMERIC(10)
            ,@correlativo          NUMERIC(10)  
            ,@corte_numero         NUMERIC(10)   
            ,@corte_monto          NUMERIC(19,4)  
            ,@corte_nominal        NUMERIC(19,4)    
            )
AS
BEGIN
      SET NOCOUNT ON
      
            INSERT INTO LETRA_HIPOTECARIA_CORTE
            (
             codigo_planilla
            ,correlativo
            ,corte_numero
            ,corte_monto
            ,corte_nominal
            )
            VALUES
            (
             @codigo_planilla
            ,@correlativo
            ,@corte_numero
            ,@corte_monto
            ,@corte_nominal
            )
           SELECT 'INSERTA'
      IF @@ERROR <> 0 BEGIN
            SELECT 'ERROR'
            
      END 
      SET NOCOUNT OFF
END 

GO
