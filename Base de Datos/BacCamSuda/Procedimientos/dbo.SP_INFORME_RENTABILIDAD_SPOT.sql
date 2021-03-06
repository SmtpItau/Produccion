USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_RENTABILIDAD_SPOT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORME_RENTABILIDAD_SPOT]
   (   @MiInforme   INTEGER
   ,   @FechaProc   DATETIME
   ,   @Usuario     VARCHAR(20) = 'Administra'
   )
AS
BEGIN

      SET NOCOUNT ON
      
      SELECT @MiInforme                         as [Indice]
      ,      Fecha                              as [A_Fecha]
      ,      DescalceInicio                     as [A_DescalceInicia]
      ,      HnfInicio                          as [A_HNFInicio]
      ,      DescalceCierre                     as [A_DescalceCierre]
      ,      HnfCierre                          as [A_HNFCierra]
      ,      TcInicio                           as [A_TcInicio]
      ,      TcCierre                           as [A_TcCierre]
      ,      UtilidadTrading                    as [A_UtilidadTradingDia]
      ,      UtilidadDescalce                   as [A_UtilidadDescalceDia]

      ,      Fecha                              as [B_Fecha]
      ,      convert(char(10),Hora,108)         as [B_Hora]
      ,      DescalceInicio                     as [B_Descalce]
      ,      Hnf                                as [B_HNF]
      ,      convert(char(10),@FechaProc,103)   as [Fecha Proceso]
      ,      convert(char(10),GETDATE(),103)    as [Fecha Emision]
      ,      convert(char(10),GETDATE(),108)    as [Hora Emision]
      ,      UPPER(@Usuario)                    as [Usuario]
      INTO   #RentabilidadPaso
      FROM   RENTABILIDAD_DINAMICA
      WHERE  Fecha = @FechaProc
      
      IF @MiInforme = 1
         DELETE #RentabilidadPaso
         WHERE  Indice = 1
         AND    B_Hora <> ( SELECT CONVERT(CHAR(10),MIN(Hora),108) FROM RENTABILIDAD_DINAMICA WHERE Fecha = @FechaProc )

      SELECT * FROM #RentabilidadPaso


END

GO
