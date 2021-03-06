USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MXCALCRENCORP]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MXCALCRENCORP](
     @ren_motipope   CHAR(1)   ,
     @ren_mocodmon   CHAR(3)   ,
     @ren_moticam    NUMERIC(19,4)  ,
     @ren_motctra    NUMERIC(19,4)  ,
     @ren_moparme    NUMERIC(19,8)  ,
     @ren_mopartr    NUMERIC(19,8)  ,
     @ren_momonmo    NUMERIC(19,4)  ,
     @xtotcoCP     NUMERIC(19,4)  ,
     @xtotveCP  NUMERIC(19,4)  ,
     @Compras_Pesos_CP NUMERIC(19,0)  ,
     @ventas_Pesos_CP NUMERIC(19,0)  ,
     @precio_medio_compra NUMERIC(15,4)  ,  
     @precio_medio_venta NUMERIC(15,4)  ,
     @xpmecoCPci   NUMERIC(15,4)  ,
     @xpmeveCPci  NUMERIC(15,4)  ,
     @xUtiliCP     NUMERIC(19,4) OUTPUT ,
     @xUticoCP     NUMERIC(19,4) OUTPUT ,
     @xUtiveCP     NUMERIC(19,4) OUTPUT ,
     @nRentab      NUMERIC(19,4) OUTPUT
      )
AS
BEGIN
   SET NOCOUNT ON
  
   DECLARE @rrda       CHAR(1)
   SELECT  @xUticoCP   = cp_utico
          ,@xUtiveCP   = cp_utive
          ,@xUtiliCP   = cp_utili
   FROM  meac
   SELECT @rrda = (SELECT mnrrda FROM VIEW_MONEDA WHERE mnnemo = @ren_mocodmon)
   IF @rrda = 'M' 
      BEGIN
--         SELECT @ren_moparme = ROUND((1/@ren_moparme),4)
--         SELECT @ren_mopartr = ROUND((1/@ren_mopartr),4)
         SELECT @ren_moparme = (1/@ren_moparme)
         SELECT @ren_mopartr = (1/@ren_mopartr)
      END
   IF @ren_motipope = 'C'
      BEGIN
         SELECT @nRentab  = (@ren_motctra/@ren_mopartr) - (@ren_moticam/@ren_moparme)
         SELECT @xUticoCP = @xUticoCP + (@nRentab * @ren_momonmo)
      END
   ELSE
      BEGIN
         SELECT @nRentab  = (@ren_moticam/@ren_moparme) - (@ren_motctra/@ren_mopartr)
         SELECT @xUtiveCP = @xUtiveCP + (@nRentab * @ren_momonmo)
      END
   EXECUTE Sp_MxUTrading @xtotcoCP,@xpmecoCPci,@xtotveCP,@xpmeveCPci,@xUtiliCP OUTPUT
End

GO
