USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORRESPONSALES_CMBMONEDA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CORRESPONSALES_CMBMONEDA]( @Opcion numeric(1) =0 )
AS
BEGIN
  SET NOCOUNT ON
  if @opcion = 0 begin 
    select  mnnemo,mncodmon
       from  moneda
 where (mnmx <> 'C') 
 ORDER BY mnnemo
   end else begin 
    select  mnnemo,mncodmon
       from  moneda
 where (mnmx = 'C') 
 ORDER BY mnnemo
   end
   
  SET NOCOUNT OFF
END

GO
