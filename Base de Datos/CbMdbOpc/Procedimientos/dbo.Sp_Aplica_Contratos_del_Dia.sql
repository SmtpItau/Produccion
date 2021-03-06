USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Aplica_Contratos_del_Dia]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--sp_helptext Sp_Aplica_Contratos_del_Dia  
-- Sp_Aplica_Contratos_del_Dia '20081209' 
--
CREATE PROC [dbo].[Sp_Aplica_Contratos_del_Dia]( @FechaApertura datetime )
As
BEGIN

   SET NOCOUNT ON 
   -- *******************************************
   -- Documentacion
   -- El sistema permitirá grabar contratos con 
   -- fecha de contrato futuras.
   -- Los contratos serán aplicados en cartera
   -- a medida que se cumpla FechaContrato
   -- *******************************************

   declare @nregs integer
   declare @ncont integer
   declare @NumFolio numeric(10)
   declare @ControlProc    integer

   select @ControlProc = 0

   Create Table #ControlSp_AppMvtCar
   (  Resultado Varchar(2)
    , Mensaje   VarCHar(80)
   )

   SELECT  Enc.MoNUmFolio
   ,       'Id_Puntero' = Identity(INT)
   INTO    #TMP_CAR
   FROM    MoEncContrato Enc
   where   MOFechaContrato = @FechaApertura


   SET @nregs = (SELECT MAX(Id_Puntero) FROM #TMP_CAR)
   SET @ncont = (SELECT MIN(Id_Puntero) FROM #TMP_CAR)

   WHILE @nregs >= @ncont
   BEGIN  

      SELECT @NumFolio       = MoNumFolio
      FROM   #TMP_CAR 	
      WHERE  Id_Puntero      = @ncont


      truncate table #ControlSp_AppMvtCar
      insert into #ControlSp_AppMvtCar
      EXEC Sp_AppMvtCar @NumFolio
      select @ControlProc = Case when Resultado = 'SI' then 0 else 1 end  
        from #ControlSp_AppMvtCar
    
      select 'POR HACER: Ejecutar después del recálculo !!! '
      -- PENDIENTE APLICAR LCR 

      SET @ncont   = @ncont + 1

   END -- While
   return( @ControlProc )
END

GO
