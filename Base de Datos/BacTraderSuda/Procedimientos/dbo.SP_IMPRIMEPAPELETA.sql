USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRIMEPAPELETA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado DBO.SP_IMPRIMEPAPELETA    fecha de la secuencia de comandos: 05/04/2001 13:13:30 ******/
CREATE PROCEDURE [dbo].[SP_IMPRIMEPAPELETA] ( @nrutcart numeric(09,0),
                         @nnumoper numeric(10,0))
 as
 begin
 -- definici=n de variables
 declare @tipoper char(3)
 declare @cmacro  varchar(80)
 select @tipoper= motipoper
 from MDMO
 where morutcart=@nrutcart and monumoper=@nnumoper
 select @cmacro = rtrim('Sp_Imprime'+@tipoper)
 if exists( select name from SYSOBJECTS where type='P' and name=@cmacro)
           begin
           execute @cmacro @nrutcart,
      @nnumoper
 end
 end


GO
