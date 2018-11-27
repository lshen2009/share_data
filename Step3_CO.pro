pro try
years=[2005,2012,2016]
num=N_ELEMENTS(years)*1

CO=fltarr(144,91,num)*!VALUES.F_NAN

kk=0
for iyear=0,N_ELEMENTS(years)-1 do begin
 year=years[iyear]
 for month=6,6 do begin
print,"======================================"
date=year*100L+month
ctm_cleanup
 print,date

tau0 = year*10000L + month*100L + 1L
filename="data/ctm.bpch."+strtrim(date,2)
print,filename
ap=strtrim(year-(year mod 2),2)
ap2=year-(year mod 2)

ctm_get_data,datainfo,"BIOBSRCE",filename=filename,tracer=4
CO[*,*,kk]=*(datainfo[0].data)

kk=kk+1
endfor
endfor

;------------------------------------
           output_name='fires_CO_2005-2016.nc'
           FID = NCDF_CREATE( output_name, /CLOBBER )
           sLON = NCDF_DIMDEF( FID, 'lon',      144 )
           sLAT = NCDF_DIMDEF( FID, 'lat',      91)
           sTime= NCDF_DIMDEF( FID, 'time',     num)
           NCDF_CONTROL, FID, /ENDEF
           NCDF_SET, FID, CO, 'CO', [sLON,sLAT,sTime]
           NCDF_CLOSE, FID
           close, /all
end
