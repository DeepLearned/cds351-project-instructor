module dataset_mod
    implicit none
    private
    public :: dataset_t, summary_stats_t
    
    type :: dataset_t
        character(len=80) :: name = ""
        character(len=20) :: units = ""
        real :: missing_value = -999.0
        real, allocatable :: values(:)
    end type dataset_t
    
    type :: summary_stats_t
        integer :: nvalid = 0
        real :: total = 0.0
        real :: minimum = 0.0
        real :: maximum = 0.0
        real :: mean = 0.0
    end type summary_stats_t
    
end module dataset_mod
