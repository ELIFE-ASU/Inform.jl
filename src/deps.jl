macro checked_lib(libname, path)
    const libptr = if VERSION >= v"0.4.0-dev+3844" 
        Base.Libdl.dlopen_e(path)
    else
        Base.dlopen_e(path)
    end 

    found = libptr != C_NULL
    if !found
        error("Unable to load $libname ($path)\n")
    end

    quote
        const $(esc(symbol(libname,"_found"))) = $found
        const $(esc(libname)) = $libptr
    end
end

@checked_lib _libinform "libinform"

