USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNCION_MXMTOUSD30]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNCION_MXMTOUSD30] (
                                        @Aux_Mocodmon  CHAR(3)            -- codigo de moneda
                                       ,@Aux_Momonmo   NUMERIC(19,4)      -- monto de la moneda
                                       ,@valorRetorno  NUMERIC(19,4) OUT  -- valor Retorno
             )
AS
BEGIN 
  DECLARE  @aux_vmparidad NUMERIC(19,4)
  DECLARE  @rrda          CHAR(1)
  IF @Aux_Mocodmon = 'USD'
 BEGIN 
        SELECT @valorRetorno = @Aux_Momonmo
  RETURN
 END
  SET @aux_vmparidad = (SELECT vmparidad from VIEW_POSICION_SPT , meac WHERE vmcodigo = @Aux_Mocodmon and ACFECPRO = vmfecha )
  SET @rrda          = (SELECT mnrrda FROM view_moneda WHERE mnnemo=@Aux_Mocodmon)
  
  IF @aux_vmparidad =0.0 
  BEGIN 
     SET @aux_vmparidad = (SELECT vmparmes from VIEW_POSICION_SPT , meac WHERE vmcodigo = @Aux_Mocodmon and ACFECPRO = vmfecha )
  END
 
  SET @aux_vmparidad = ISNULL(@aux_vmparidad,0)
  
  If @aux_vmparidad = 0 
    BEGIN
      Set @valorRetorno = 0
    END 
  ELSE 
    BEGIN 
--       IF @rrda = 'D' 
--         BEGIN
           SELECT @valorRetorno = ROUND( (CASE @Aux_Momonmo WHEN 0 THEN 1 ELSE @Aux_Momonmo END) / @aux_vmparidad , 4 ) --retornar       
--         END
--       ELSE 
--         BEGIN
--           set @valorRetorno = Round( (@aux_vmparidad * @Aux_Momonmo ) ,4) --retornar
--         END
    END
END
GO
