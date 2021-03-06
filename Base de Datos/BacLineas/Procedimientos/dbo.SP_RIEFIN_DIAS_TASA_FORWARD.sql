USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_DIAS_TASA_FORWARD]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_DIAS_TASA_FORWARD]
(  @CodigoTasa numeric(5)
)
As 
Begin  
-- Periodicidad de la tasa indicada 
-- como parámetro
-- SP_RIEFIN_DIAS_TASA_FORWARD 10
        declare @Dias numeric(10) 
        set @Dias = 0
        select @Dias = dias from BacParamSuda..PERIODO_AMORTIZACION Per,
                         BacParamsuda..tabla_general_Detalle Tas
        where Per.tabla = 1044   
          and Tas.tbcateg = 1042 
          and per.codigo = Tas.tbtasa  
          and tbcodigo1  = @CodigoTasa 
		Select Dias = @Dias
End
GO
