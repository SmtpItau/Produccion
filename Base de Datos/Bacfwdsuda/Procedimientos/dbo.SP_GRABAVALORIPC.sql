USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAVALORIPC]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAVALORIPC]
                                 (
       @FecCalc    DATETIME       ,
       @ValorUF    NUMERIC(12,2)  ,
       @ValorIPC   NUMERIC(6,2)
      )
AS
BEGIN
SET NOCOUNT ON
 /*=======================================================================*/
 /*=======================================================================*/
   IF EXISTS( SELECT  ipcfeccal FROM  view_ipc_uf_proyectada
                                  WHERE ipcfeccal = @FecCalc ) BEGIN
      UPDATE  view_ipc_uf_proyectada SET ipcfeccal   = @FecCalc     ,
                 ipcvaloruf  = @ValorUF     ,
          ipcvaloripc = @ValorIPC
   WHERE ipcfeccal = @FecCalc
   END ELSE BEGIN
      INSERT INTO view_ipc_uf_proyectada VALUES ( @FecCalc, @ValorUF  , @ValorIPC)
   END
   /*=======================================================================*/
   /*=======================================================================*/
SET NOCOUNT OFF
   RETURN 0
END

GO
