USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRABIDASK]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRABIDASK]( 
    @dfecha  datetime,
    @codmon  numeric(03)
    )
AS BEGIN
   SET NOCOUNT ON
   DELETE  FROM  MFBIDASK
   where  fecha = @dfecha and
  (moneda = @codmon or
   @codmon = 0)
   SET NOCOUNT Off
   SELECT  0
END

GO
