USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_IPCPR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_GRABAR_IPCPR]
 ( @ipc_cont  numeric (03,00)  ,
 @ipc_valor  numeric (03,02)  )
 as
 begin
 insert into MDIPCPR (ipc_cont  ,
        ipc_valor  )
 values       (@ipc_cont  ,
        @ipc_valor  )
 end
                                

GO
