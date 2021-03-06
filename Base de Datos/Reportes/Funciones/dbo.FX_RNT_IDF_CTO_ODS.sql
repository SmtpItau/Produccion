USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[FX_RNT_IDF_CTO_ODS]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[FX_RNT_IDF_CTO_ODS]
(
     @NUM_DOCUMENTO	    NUMERIC(20) = 0
    ,@NUM_OPERACION	    NUMERIC(20) = 0
    ,@CORRELATIVO	    NUMERIC(20) = 0
    ,@ID_SISTEMA	    VARCHAR(5)	= 0
    ,@T_FLUJO		    NUMERIC(1)	= 0    
)
returns varchar(32)
as 
begin    
    if (@NUM_DOCUMENTO is null) and (@NUM_OPERACION is null) begin
	   return replicate('-',14) + 'N/C' + replicate('-',15)
    end 

    if @CORRELATIVO is null begin
	   set @CORRELATIVO = 0
    end

    if @NUM_DOCUMENTO is null begin
	   set @NUM_DOCUMENTO = 0
    end 
    if @NUM_OPERACION is null begin
	   set @NUM_OPERACION = 0
    end




    declare 
	   @result		   varchar(32)
	   ,@aux_folio		   numeric
	   ,@aux_num_documento varchar(12)
	   ,@aux_num_operacion varchar(12)
	   ,@aux_correlativo   varchar(4)	
    
    -- auxiliar para serializacion de flujo
    set @aux_folio = (case  @T_FLUJO
				    when 1 then 1000
				    when 2 then 2000
				    else 0
				  end)


if @correlativo <1000 
begin
	set @correlativo = (case upper(@id_sistema)
					   when 'PCS' then @correlativo + @aux_folio
					   when 'BFW' then @correlativo + @aux_folio
					   else @correlativo
				     end)
end 

set @aux_num_documento = (case @NUM_DOCUMENTO
						 when null then replicate('0',12)
						 when -1	 then replicate('0',12)						 
						 else ltrim(rtrim(convert(varchar,@num_documento)))
					 end)
set @aux_num_operacion = (case @NUM_OPERACION
    						 when null then replicate('0',12)
						 when -1	 then replicate('0',12)
						 else ltrim(rtrim(convert(varchar,@num_operacion)))
					 end)
set @aux_correlativo    = (case @correlativo
						 when null then replicate('0',4)
						 when -1	 then replicate('0',4)
						 else ltrim(rtrim(convert(varchar,@correlativo)))
					   end)

set @result = 
   space(4) 
   +right(replicate('0',12) + @aux_num_documento,12)						  
   +right(replicate('0',12) + @aux_num_operacion,12)
   +right(replicate('0',4)  + @aux_correlativo,4)

return @result

end
GO
