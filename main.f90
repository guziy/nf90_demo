
        program test
         use netcdf
         implicit none 
                

        
         ! This is the name of the data file we will read. 
         character (len = *), parameter :: FILE_NAME = &
                 "bathy_meter_sel.nc"

        ! We are reading 2D data 
        integer :: nx, ny, ndims
        real, allocatable :: data_in(:, :)
        

        ! This will be the netCDF ID for the file and data variable.
        integer :: ncid, varid, x_dim_id, y_dim_id

        ! Loop indexes, and error handling.
        integer :: x, y, dim_ids(nf90_max_var_dims), i
        integer :: include_parents

        character(len=NF90_MAX_NAME) :: xname, yname        


        ! Open the file. NF90_NOWRITE tells netCDF we want read-only access to
        ! the file.
        call check( nf90_open(FILE_NAME, NF90_NOWRITE, ncid) )

        ! Get the varid of the data variable, based on its name.
        call check( nf90_inq_varid(ncid, "Bathymetry", varid) )

        !Get var dimensions
        dim_ids = -1
        include_parents = 0
        call check(nf90_inq_dimids(ncid, ndims, dim_ids, include_parents))
        do i = 1, ndims
                print*, dim_ids(i)
        enddo
        x_dim_id = dim_ids(2)
        y_dim_id = dim_ids(1)

        call check(nf90_inquire_dimension(ncid, y_dim_id, xname, nx))
        call check(nf90_inquire_dimension(ncid, x_dim_id, yname, ny))

        print*, trim(xname), ", ", trim(yname)
        print*, nx, ", ", ny

        allocate(data_in(ny, nx))                

        ! Read the data.
        call check( nf90_get_var(ncid, varid, data_in) )



        ! Check the data.
        do x = 1, nx
        do y = 1, ny
              print *, "data_in(", y, ", ", x, ") = ", data_in(y, x)
        end do
        end do

        ! Close the file, freeing all resources.
        call check( nf90_close(ncid) )

        print *,"*** SUCCESS reading example file ", FILE_NAME, "! "



         contains
          subroutine check(status)
                integer, intent ( in) :: status
    
                if(status /= nf90_noerr) then 
                        print *, trim(nf90_strerror(status))
                        stop "Stopped"
                end if
          end subroutine check  


        end program test
