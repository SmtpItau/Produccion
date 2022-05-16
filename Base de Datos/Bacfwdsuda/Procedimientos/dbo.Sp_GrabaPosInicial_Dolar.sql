USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GrabaPosInicial_Dolar]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create proc [dbo].[Sp_GrabaPosInicial_Dolar] (@PosMoneda  float,
          @acfecpro   datetime,
          @Moneda     char (3)) 
as
begin
update view_posicion_spt set vmposini = @PosMoneda
     
where vmcodigo = @Moneda and
      vmfecha  = @acfecpro
end
-- Sp_GrabaPosInicial_Dolar 1,'20010523','usd'
GO
