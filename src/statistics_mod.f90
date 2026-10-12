module stats_mod
    use dataset_mod, only: dataset_t, summary_stats_t
    implicit none
    private
    public :: summarize_dataset
    
contains

    function summarize_dataset(obs) result(summary)
        type(dataset_t), intent(in) :: obs
        type(summary_stats_t) :: summary
        call summarize(obs%values, obs%missing_value, &
            summary%total, summary%minimum, &
            summary%maximum, summary%nvalid)
        summary%mean = mean_from_total(summary%total, &
            summary%nvalid, &
            obs%missing_value)
    end function summarize_dataset
    
    pure function mean_from_total(total, nvalid, missing_value) result(mean)
        implicit none
        real, intent(in) :: total
        real, intent(in) :: missing_value
        integer, intent(in) :: nvalid
        real :: mean
        
        if (nvalid > 0) then
            mean = total / real(nvalid)
        else
            mean = missing_value
        end if
        
    end function mean_from_total
    
    subroutine summarize(values, missing_value, total, minimum, maximum, nvalid)
        implicit none
        real, intent(in) :: values(:)
        real, intent(in) :: missing_value
        real, intent(out) :: total, minimum, maximum
        integer, intent(out) :: nvalid
        integer :: i
        
        nvalid = 0
        total = 0.0
        minimum = huge(0.0)
        maximum = -huge(0.0)
        do i = 1, size(values)
            if (values(i) == missing_value) cycle
            nvalid = nvalid + 1
            total = total + values(i)
            minimum = min(minimum, values(i))
            maximum = max(maximum, values(i))
        end do
        
    end subroutine summarize


end module stats_mod
