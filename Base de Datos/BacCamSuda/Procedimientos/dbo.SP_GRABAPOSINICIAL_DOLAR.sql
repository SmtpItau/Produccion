USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAPOSINICIAL_DOLAR]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAPOSINICIAL_DOLAR] 
               ( @PosMoneda  FLOAT
               ,@acfecpro   DATETIME
               ,@Moneda     CHAR(3)
               ,@Paridaddia FLOAT                             
                ) 
AS
BEGIN
  UPDATE view_posicion_spt 
     SET vmposini = @PosMoneda
        ,vmposic  = @PosMoneda
        ,vmparidad = @Paridaddia  
     
   WHERE vmcodigo = @Moneda and
         vmfecha  = @acfecpro 
  
  UPDATE meac 
     SET acposini = @PosMoneda
        ,acposic  = (@PosMoneda + actotco) - actotve
--        ,acprecie = ROUND(((actotco*acpmeco)+(actotve*acpmeve))/(actotco+actotve),4)
   WHERE @Moneda  = 'USD' and
         acfecpro = @acfecpro 
END

GO
