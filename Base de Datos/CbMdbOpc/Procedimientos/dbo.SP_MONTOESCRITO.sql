USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_MONTOESCRITO]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_MONTOESCRITO]  
    (  
    @nnumero numeric (19,4)  ,  
    @mtoesc  char (170) OUTPUT  
    )  
as  
begin  
set nocount on  
 declare @decimal char (16) ,  
  @denomi   char (06) ,  
  @i  integer  ,  
  @z  char (255) ,  
  @k  char (255) ,  
  @c  integer  ,  
  @d  integer  ,  
  @u  integer  ,  
  @v  integer  ,  
  @n  char (255) ,  
  @frase   char (10) ,  
  @frase1   char (10) ,  
  @x  char (10) ,  
  @y  char (10)  
 select @x  = '( '     ,  
  @y  = ' . ) '    ,  
  @decimal = substring(str(@nnumero,19,4),16,4) --ASVG_20110317 dos decimales --ASVG_20110321 vuelta a 4 decimales.  
  
 if @nnumero>99999999999999  
 begin  
  select '*'  
 end  
   
select @n = '   ' + ' ' + substring(str(@nnumero,19,4),1,14) ,  
  @i = 1       ,  
  @z = ''  
 while rtrim(substring(@n,18-(@i*3-1),3))<>' '  
 begin  
  select @k = substring(@n,18-(@i*3-1),3)  
  select @c = convert(integer,substring(@k,1,1)) ,  
   @d = convert(integer,substring(@k,2,1)) ,  
   @u = convert(integer,substring(@k,3,1)) ,  
   @v = convert(integer,substring(@k,2,2))  
  if @i>1  
  begin  
   if (@i=2 or @i=4) and convert(integer,substring(@k,1,3))>0  
    select @z = ' MIL '+rtrim(@z)  
   if @i=3 and convert(integer,substring(@n,7,6))>0  
   begin  
    if convert(integer,substring(@k,1,3))=1  
     select @z = ' MILLON '+rtrim(@z)  
    else  
     select @z = ' MILLONES '+rtrim(@z)  
   end  
   if @i=5 and convert(integer,substring(@k,1,3))>0  
   begin  
    if convert(integer,substring(@k,1,3))=1  
     select @z = ' BILLON '+rtrim(@z)  
    else  
     select @z = ' BILLONES '+rtrim(@z)  
   end  
  end  
  if @v>0  
  begin  
   if @v<16  
   begin  
    select @frase = rtrim(glosa) from lnkbac.bactradersuda.dbo.MDDESNUM where indice=@v  
    select @z = rtrim(@frase)+rtrim(@z)  
   end  
   else  
    if @v<20  
    begin  
     select @frase = rtrim(glosa) from lnkbac.bactradersuda.dbo.MDDESNUM where indice=@u  
     select @z = 'DIECI'+rtrim(@frase)+rtrim(@z)  
    end  
    else  
     if @v=20  
      select @z = 'VEINTE'+rtrim(@z)  
     else  
      if @v<30  
      begin  
       select @frase = rtrim(glosa) from lnkbac.bactradersuda.dbo.MDDESNUM where indice=@u  
       select @z = 'VEINTI'+rtrim(@frase)+rtrim(@z)  
      end  
      else  
       if @u=0  
       begin  
        select @frase = rtrim(glosa) from lnkbac.bactradersuda.dbo.MDDESNUM2 where indice=@d  
        select @z = rtrim(@frase)+rtrim(@z)  
       end  
       else  
       begin  
        select @frase = rtrim(glosa) from lnkbac.bactradersuda.dbo.MDDESNUM2 where indice=@d  
        select @frase1 = rtrim(glosa) from lnkbac.bactradersuda.dbo.MDDESNUM where indice=@u  
        select @z = rtrim(@frase)+' Y '+rtrim(@frase1)+rtrim(@z)  
       end  
  end  
  if @c>0  
  begin  
   if @c=1  
   begin  
    if @v=0  
     select @z = 'CIEN '+rtrim(@z)  
    else  
     select @z = 'CIENTO '+rtrim(@z)  
   end  
   else  
    if @c=2 or @c=3 or @c=4 or @c=6 or @c=8  
    begin  
     select @frase = rtrim(glosa) from lnkbac.bactradersuda.dbo.MDDESNUM where indice=@c  
     select @z = rtrim(@frase)+'CIENTOS '+rtrim(@z)  
    end  
    else  
     if @c=5  
      select @z = 'QUINIENTOS '+rtrim(@z)  
     else  
      if @c=7  
       select @z = 'SETECIENTOS '+rtrim(@z)  
      else  
       if @c=9  
        select @z = 'NOVECIENTOS '+rtrim(@z)  
  end  
  if rtrim(@n) is null  
   break  
  else  
  begin  
   select @i = @i + 1  
   continue  
  end  
 end  
/*  
 if @decimal='0000'  
  select @decimal = '' ,  
   @denomi  = ''  
 else  
 begin  
  select @decimal = ' CON '+rtrim(@decimal)+'/10000'  
 end  
*/  
  
--ASVG_20111109 Se mueve este control para que en el caso de input nnnmero=0, el resultado retornado salga en una sola línea (un solo select).  
 if @nnumero=0.0  
 begin  
  select @z = 'CERO'  
 end  
  
 select @decimal = ' CON '+rtrim(@decimal)+'/10000' --ASVG_20110321 vuelta a 4 decimales.  
 select @mtoesc = rtrim(@x)+' '+rtrim(@z)+@decimal+' '+rtrim(@y)  
END
GO
