USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MXRECALCCX]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MXRECALCCX] 
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
DECLARE @xtotco    numeric(10)
DECLARE @xtotcop   numeric(10) 
DECLARE @xtotve    numeric(10)
DECLARE @xtotvep   numeric(10)
DECLARE @xpmeco    numeric(10,4)
DECLARE @xpmeve    numeric(10,4)
DECLARE @xutili    numeric(10)
DECLARE @xtotcore  numeric(10)   
DECLARE @xtotcopre numeric(10)
DECLARE @xpmecore  numeric(10)
DECLARE @xtotvere  numeric(10)
DECLARE @xtotvepre numeric(10)
DECLARE @xpmevere  numeric(10)
DECLARE @xposic    numeric(10)
DECLARE @xpohedge  numeric(10)
DECLARE @xpohefut  numeric(10)
DECLARE @xpohespt  numeric(10)
DECLARE @xUhedge   numeric(10)
DECLARE @xValor    numeric(10)
DECLARE @xposic1   numeric(10)
DECLARE @xposic2   numeric(10)
DECLARE @pFuturo   Char(1)
DECLARE @qUtrading numeric(10) 
DECLARE @xPoshini  numeric(10)
DECLARE @xPrehini  NUMERIC(10)
DECLARE @xPrecie   NUMERIC(10) 
DECLARE @qUhedge   NUMERIC(10)     
DECLARE @aux_moussme   numeric
DECLARE @aux_moticam   numeric
DECLARE @aux_motipope  char
DECLARE @aux_motipmer  char
DECLARE @aux_trading   char
DECLARE @aux_rentabilidad char
DECLARE @aux_posicion  char
DECLARE @aux_hedge     char
select @pfuturo = 'F'
select @xpmecore = 0
select @xpmevere = 0
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 Create Table #Tabla_paso
              (  xtotco     NUMERIC(10) NOT NULL 
  ,xtotcop   numeric(10) NOT NULL 
  ,xtotve    numeric(10) NOT NULL
  ,xtotvep   numeric(10) NOT NULL
  ,xpmeco    numeric(10,4) NOT NULL
  ,xpmeve    numeric(10,4) NOT NULL
  ,xutili    numeric(10) NOT NULL
  ,xtotcore  numeric(10) NOT NULL   
  ,xtotcopre numeric(10) NOT NULL
  ,xpmecore  numeric(10) NOT NULL
  ,xtotvere  numeric(10) NOT NULL
  ,xtotvepre numeric(10) NOT NULL
  ,xpmevere  numeric(10) NOT NULL
  ,xposic    numeric(10) NOT NULL
  ,xpohedge  numeric(10) NOT NULL
  ,xpohefut  numeric(10) NOT NULL
  ,xpohespt  numeric(10) NOT NULL
  ,xUhedge   numeric(10) NOT NULL
  ,xValor    numeric(10) NOT NULL
  ,xposic1   numeric(10) NOT NULL
  ,xposic2   numeric(10) NOT NULL
  ,pFuturo   Char(1) NOT NULL DEFAULT('')
  ,qUtrading numeric(10) NOT NULL 
  ,xPoshini  numeric(10) NOT NULL
  ,xPrehini  NUMERIC(10) NOT NULL
  ,xPrecie   NUMERIC(10) NOT NULL 
  ,qUhedge   NUMERIC(10) NOT NULL   
   )
--<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 select 
        'xPoHepSpi' = achedgeinicialspot   ,
        'xPrehIni ' = achedgeprecioinicial ,
        'xPrecie  ' = acprecie
          
       from meac
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><-
   -- Declaracion del cursor
  Declare Memo_Cursor CURSOR for
  Select  moussme,moticam,motipope,motipmer,trading,rentabilidad,posicion,hedge From memo , tbafectoaposicion  Where motipmer = nemo  order by monumope
  open Memo_Cursor
  fetch NEXT FROM Memo_Cursor
  into @aux_moussme
       ,@aux_moticam
       ,@aux_motipope 
       ,@aux_motipmer
       ,@aux_trading
       ,@aux_rentabilidad
       ,@aux_posicion
       ,@aux_hedge
       
  while (@@fetch_status = 0)
      Begin
       --- TRADING
      select @xTotco  = (select isnull(sum(moussme),0) from memo , tbafectoaposicion  where motipope='C' and trading = 'V' and motipmer = nemo)
      select @xtotcop = (select round(sum(moussme*moticam),4) from memo,tbafectoaposicion  where memo.motipope='C' and tbafectoaposicion.trading='V' and motipmer = nemo )
      select @xtotve  = (select isnull(sum(moussme),0) from memo, tbafectoaposicion where memo.motipope='V' and tbafectoaposicion.trading='V' and motipmer = nemo)
      select @xtotvep = (select isnull(sum(moussme*moticam),0) from memo,tbafectoaposicion  where motipope='V' and trading='V' and motipmer = nemo )
      return @xTotco 
      If @xtotco<>0 Begin
 select @xpmeco = Round(@xTotco / @xtotcop,4)
        End Else Begin
         select @xpmeco = 0
      End
     
      If @xtotve<>0 Begin 
  select  @xpmeve = Round(@xtotve/@xtotvep,4)
        End Else Begin
         select @xpmeve=0
      End
      If @xtotco<@xtotve begin 
         select @qUtrading =(@xPmeve - @xPmeco)* @xtotco
       End else Begin
         select @qUtrading =(@xPmeve - @xPmeco)* @xtotve
      End
      
      -- Rentabilidad
      select @xTotcore  = (select isnull(sum(moussme),0) from memo, tbafectoaposicion  where motipope='C' and rentabilidad='C' and motipmer = nemo)
      select @xtotcopre = (select isnull(sum(moussme * moticam),0) from memo,tbafectoaposicion  where motipope='C' and trading='V' and motipmer = nemo )
      select @xtotvere  = (select isnull(sum(moussme),0) from memo, tbafectoaposicion where motipope='C' and rentabilidad='V' and motipmer = nemo)
      select @xtotvepre = (select isnull(sum(moussme * moticam),0) from memo,tbafectoaposicion  where motipope='C' and rentabilidad='V' and motipmer = nemo )
      
       If @xtotcore <> 0 and @xtotcopre <> 0  Begin 
          select @xpmecore  = Round(@xTotcore/@xtotcopre,4)
          select @xpmevere  = Round(@xtotvere/@xtotvepre,4)
       end
       -- Posicion      
      select @xposic1  = (select isnull(sum(moussme),0) from memo, tbafectoaposicion where motipope='C' and posicion='C' and motipmer = nemo) -- compra
      select @xposic2  = (select isnull(sum(moussme),0) from memo, tbafectoaposicion where motipope='V' and posicion='V' and motipmer = nemo) -- venta
                                            
      -- HEDGE
      If @pFuturo= 'V' Begin 
         select @xpohedge  = (select isnull(sum(moussme),0) from memo, tbafectoaposicion where motipope='C' and hedge='V' and motipmer = nemo)
         select @xpohefut  = (select isnull(sum(moussme),0) from memo, tbafectoaposicion where motipope='C' and hedge='V' and motipmer = nemo)
         select @xpohespt  = (select isnull(sum(moussme),0) from memo, tbafectoaposicion where motipope='C' and hedge='V' and motipmer = nemo)
        End Else Begin 
         select @xpohedge  = (select isnull(sum(moussme),0) from memo, tbafectoaposicion where motipope='V' and hedge='V' and motipmer = nemo)
         select @xpohefut  = (select isnull(sum(moussme),0) from memo, tbafectoaposicion where motipope='V' and hedge='V' and motipmer = nemo)
         select @xpohespt  = (select isnull(sum(moussme),0) from memo, tbafectoaposicion where motipope='V' and hedge='V' and motipmer = nemo)
      End 
    
      If @xTotve < @xtotco  Begin
         select @qUhedge = ABS((@xPoshini*(@xPrehini-@xPrecie))+(@xtotco-@xtotve)*(@xprecie-@xPmeco))
       End Else Begin
         select @qUhedge = ABS((@xPoshini*(@xPrehini-@xPrecie))+(@xtotco-@xtotve)*(@xprecie-@xPmeve))
      End
  
      fetch Memo_Cursor
      into @aux_moussme
          ,@aux_moticam
          ,@aux_motipope 
          ,@aux_motipmer
          ,@aux_trading
          ,@aux_rentabilidad
          ,@aux_posicion
          ,@aux_hedge
   End  --while
   Close Memo_Cursor
   Deallocate Memo_Cursor
  End

GO
