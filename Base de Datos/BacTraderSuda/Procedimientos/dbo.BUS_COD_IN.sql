USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[BUS_COD_IN]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[BUS_COD_IN] (  
     @codigo numeric(10)      --p1
    ,@monemis numeric(3)     --p2
    ,@rutemis numeric(8) --p3
    ,@cartera nvarchar(6) --p4
    ,@xcomp_inv numeric(5)=0  output
    )
as
begin 
SET NOCOUNT ON
declare @xrutestado  numeric(8)
declare @xrut   numeric(8)
declare @xtipo   numeric(5)
set @xrutestado = 97030000
set @xrut       = 97023000   
set @xtipo  = 0
set @xtipo = isnull((select Cltipcli from view_cliente where Clrut=@rutemis),0)
if @codigo=  15   begin 
        if @rutemis = @xrutestado  
                set @xcomp_inv = 21402
                --xprod     = 440
        if   @xtipo = 1
                set @xcomp_inv = 22104
                --xprod     = 440
        if  @rutemis = 306 and @monemis = 900 
                set @xcomp_inv = 30001
               --xprod     = 460
        if @rutemis = 1500000 and @monemis = 900 
               set @xcomp_inv = 30001
               --xprod     = 460
        if @rutemis = 8 and @monemis = 900 
               set @xcomp_inv = 11199
               --xprod     = 460
           else
               set @xcomp_inv = 12001
               --xprod     = 460
        
 end else begin 
     if @codigo = 14 and @monemis = 142 
        set @xcomp_inv = 30002
        --xprod     = 460
     if @codigo = 13 and @monemis = 900 
        set @xcomp_inv = 30002
        --xprod     = 460
     if @codigo = 20 Or @codigo = 21 or @codigo = 22 or @codigo = 23 begin
         if @rutemis = @xrut 
  set @xcomp_inv = 22101
                --xprod     = 460
         if @rutemis = @xrutestado 
  set  @xcomp_inv = 21401
                --xprod := 440
             else  set @xcomp_inv = 22103
                --xprod := 440
     end
END 
return @xcomp_inv
end    --  OTHERWISE
/*
        Select mdtb84
        If dbseek( Str(p1,3) + Str(p2,3) )
            xcomp_inv := codinv
            xprod     := producto
        Endif
If p4$'114-115'
   xprod := 470
Endif
*/ 
 
GO
