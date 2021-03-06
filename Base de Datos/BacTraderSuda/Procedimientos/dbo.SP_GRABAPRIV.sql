USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAPRIV]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAPRIV]( @cusuario char(15) ,
                               @nopcion  integer  )
as
begin
       declare @cnivel  char(11)
       declare @cparent char(11)
       declare @ncont   integer
     /*-------------------------------------------------------*
      * lee el nivel asociado al codigo de funci_n.-          *
      *-------------------------------------------------------*/
       select @cnivel  = mnivel ,
              @cparent = mnivel
              from BACMENU where mopcion = @nopcion
       if @@rowcount = 0
          return
     /*-------------------------------------------------------*
      * busca el nivel final de la funci_n.-                  *
      *-------------------------------------------------------*/
       select @ncont = 10
       while @ncont > 2
       begin
             if substring(@cnivel,@ncont,2) <>  '00'
                break
             select @ncont = @ncont - 2
       end
     /*-------------------------------------------------------*
      * busca los niveles padres de la funci_n.-              *
      *-------------------------------------------------------*/
       while @ncont > 2
       begin
             select @cparent = stuff(@cparent,@ncont,2,'00')
             if exists( select nivel from BACPRIV where usuario = @cusuario and nivel = @cparent )
                break
             insert into BACPRIV (usuario,nivel) values (@cusuario,@cparent)
             select @ncont = @ncont - 2
       end
     /*-------------------------------------------------------*
      * registra el privilegio de la funci_n.-                *
      *-------------------------------------------------------*/
       insert into BACPRIV (usuario,nivel) values (@cusuario,@cnivel)
end

GO
