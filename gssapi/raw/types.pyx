GSSAPI="BASE"  # This ensures that a full module is generated by Cython

from gssapi.raw.cython_types cimport *
from gssapi.raw.oids cimport OID

from flufl.enum import IntEnum


cdef OID c_make_oid(gss_OID oid):
    cdef OID res = OID()
    res.raw_oid = oid[0]
    return res


class NameType(object):
    """
    GSSAPI Name Types

    This IntEnum represents GSSAPI name types
    (to be used with importName, etc)

    Note that the integers behind these
    enum members do not correspond to any numbers
    in the GSSAPI C bindings, and are subject
    to change at any point.
    """

    # mech-agnostic name types
    hostbased_service = c_make_oid(GSS_C_NT_HOSTBASED_SERVICE)
    # NB(directxman12): skip GSS_C_NT_HOSTBASED_SERVICE_X since it's deprecated
    user = c_make_oid(GSS_C_NT_USER_NAME)
    anonymous = c_make_oid(GSS_C_NT_ANONYMOUS)
    machine_uid = c_make_oid(GSS_C_NT_MACHINE_UID_NAME)
    string_uid = c_make_oid(GSS_C_NT_STRING_UID_NAME)
    export = c_make_oid(GSS_C_NT_EXPORT_NAME)

    # mech-specific name types
    principal = c_make_oid(GSS_KRB5_NT_PRINCIPAL_NAME)


class RequirementFlag(IntEnum):
    """
    GSSAPI Requirement Flags

    This IntEnum represents flags to be used in the
    service flags parameter of initSecContext.

    The numbers behind the values correspond directly
    to their C counterparts.
    """

    delegate_to_peer = GSS_C_DELEG_FLAG
    mutual_authentication = GSS_C_MUTUAL_FLAG
    replay_detection = GSS_C_REPLAY_FLAG
    out_of_sequence_detection = GSS_C_SEQUENCE_FLAG
    confidentiality = GSS_C_CONF_FLAG
    integrity = GSS_C_INTEG_FLAG
    anonymous = GSS_C_ANON_FLAG
    transferable = GSS_C_TRANS_FLAG


class MechType(object):
    """
    GSSAPI Mechanism Types

    This class acts like an Enum, but is not

    The elements of this pseudo-Enum are OID objects.

    """

    kerberos = c_make_oid(gss_mech_krb5)
