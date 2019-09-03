%==========================================================================
% parse_input()
function Nii = parse_input(pths)
if iscell(pths)
    C   = numel(pths);
    Nii = cell(1,C);
    for c=1:C
        Nii{c} = nifti(pths{c});
    end
elseif ischar(pths) && (exist(pths,'dir') == 7)
    dirs = spm_select('List',pths,'dir');    
    C    = size(dirs,1);
    if C > 0
        Nii = cell(1,C);
        for c=1:C
            d      = deblank(dirs(c,:));
            d      = fullfile(pths,d);
            Nii{c} = nifti(spm_select('FPList',d,'^.*\.nii$'));
        end
    else
        files = spm_select('FPList',pths,'^.*\.nii$');
        C     = size(files,1);
        Nii   = cell(1,C);
        for c=1:C
            f      = deblank(files(c,:));
            Nii{c} = nifti(f);
        end
    end
else
    error('Input error!')
end
%==========================================================================